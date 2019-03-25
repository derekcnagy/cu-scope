module AnalyticsHelper

  def most_failed_scenarios(team)
    most_failed_scenarios = {}
    scenarios = Scenario.where(feature: Feature.where(team: team))
    return most_failed_scenarios if scenarios.size.eql? 0
    test_runs = TestRun.where('time_ran > ? ', (Date.today - 30).to_datetime)
    scenarios.each do |scenario|
      test_count_total = IndividualTest.where(scenario: scenario, test_run: test_runs).size
      tests_count_failed = IndividualTest.where(scenario: scenario, test_run: test_runs, passed: false).size
      test_fail_percent = ((tests_count_failed.to_f / test_count_total.to_f) * 100).to_i
      most_failed_scenarios[scenario.id] = {scenario_name: scenario.scenario_name,
                                             test_fail_percent: test_fail_percent}
    end
    most_failed_scenarios.sort_by {|_key, value| value[:test_fail_percent]}.reverse.to_h
  end

  def longest_running_tests(team)
    scenario_durations = {}
    scenarios = Scenario.where(feature: Feature.where(team: team))
    return scenario_durations if scenarios.size.eql? 0

    test_runs = TestRun.where('time_ran > ? ', (Date.today - 30).to_datetime)

    durations = IndividualTest.where(scenario: scenarios, test_run: test_runs).collect{|test| test.duration}
    average_duration = durations.reduce(0, :+) / durations.size

    scenarios.each do |scenario|
      durations = IndividualTest.where(scenario_id: scenario.id, test_run: test_runs).collect {|test| test.duration}
      duration = durations.reduce(0, :+) / durations.size
      compared_to_average = ((duration.to_f / average_duration.to_f) * 100).to_i
      scenario_durations[scenario.id] = {scenario_name: scenario.scenario_name,
                                          duration: (duration.to_f / 1000000000.0).to_i, compared_to_average: compared_to_average}
    end
    scenario_durations.sort_by {|_key, value| value[:compared_to_average]}.reverse.to_h
  end

  def most_common_errors(team)
    most_common_errors = {}
    scenarios = Scenario.where(feature: Feature.where(team: team))
    return most_common_errors if scenarios.size.eql? 0

    test_runs = TestRun.where('time_ran > ? ', (Date.today - 30).to_datetime)
    error_messages = ErrorMessage.where(id: IndividualTest.where(scenario: scenarios, test_run: test_runs).collect { |test| test.error_message_id })
    error_messages.each do |error_message|
      error_count = IndividualTest.where(error_message_id: error_message.id, test_run: test_runs).size
      most_common_errors[error_message.id] = {error_message: error_message.error_message,
                                               error_count: error_count}
    end


    most_common_errors.sort_by {|_key, value| value[:error_count]}.reverse.to_h
  end

end
