module ReportViewerHelper
  def build_report(team_id, profile_id, from_date, to_date)
    team_id = team_id.nil? ? 1 : team_id
    to_date += " 00:00:00"
    from_date += " 23:59:59"
    test_runs = TestRun.where('time_ran Between ? and ?', to_date, from_date)
    test_runs = TestRun.where(:id => test_runs.collect {|test_run| test_run.id},
                              team_id: team_id, profile_id: profile_id).order(time_ran: :desc)
    tests = IndividualTest.where :test_run_id => test_runs.collect {|test_run| test_run.id}
    scenarios = Scenario.where :id => tests.collect {|test| test.scenario_id}
    features = Feature.where :id => scenarios.collect {|scenario| scenario.feature_id}

    test_run_times = test_runs.collect {|test_run| test_run.time_ran.strftime "%m/%d/%Y %H:%M:%S"}

    test_data = {}
    features.each do |feature|
      data = {feature_name: feature.feature_name,
              feature_description: feature.feature_description,
              scenarios: scenario_data(feature.id, test_runs)}
      test_data[feature.json_feature_id] = data
    end
    {test_run_times: test_run_times, test_data: test_data}
  end

  def scenario_data(features_id, test_runs)
    scenarios = Scenario.where feature_id: features_id
    data = {}
    scenarios.each do |scenario|
      scenario_tests = []
      test_runs.each do |test_run|
        test = IndividualTest.where(test_run: test_run, scenario_id: scenario.id).first
        if test.nil?
          scenario_tests.push nil
        else
          notes = {}
          if test[:error_message_id].nil?
            error_message = nil
          else
            error_message = ErrorMessage.where(id: test[:error_message_id]).first[:error_message]
            notes = note_data scenario.id, test[:id], test[:error_message_id]
          end
          test_info = {id: test[:id], passed: test[:passed], duration: test[:duration],
                       error_message_id: test[:error_message_id], error_message: error_message, notes: notes}
          scenario_tests.push test_info
        end

      end
      unless scenario_tests.compact.size.eql? 0
        data[scenario.json_scenario_id] = {scenario_id: scenario.id, scenario_name: scenario.scenario_name,
                                           steps: scenario.steps, scenario_description: scenario.scenario_description,
                                           scenario_tests: scenario_tests}
      end
    end
    data
  end

  def note_data(scenario_id, test_id, error_message_id)
    notes = {}
    test_notes = Note.where(individual_test_id: test_id).collect {|note| note.note}
    scenario_notes = Note.where(scenario_id: scenario_id, error_message_id: error_message_id).collect {|note| note.note}
    error_notes = Note.where(individual_test_id: nil, scenario_id: nil, error_message_id: error_message_id).collect {|note| note.note}
    notes['Test Notes'] = test_notes if test_notes.size > 0
    notes['Scenario Notes'] = scenario_notes if scenario_notes.size > 0
    notes['Error Notes'] = error_notes if error_notes.size > 0
    notes
  end
end
