module FileUploaderHelper

  def find_team(file_components)
    teams = Team.all
    teams.each do |team|
      name = team[:team_name].downcase.gsub ' ', '_'
      return team[:id] if file_components.include? name
    end
    Team.find(1)[:id]
  end

  def find_profile(file_components, team)
    profiles = Profile.where team_id: team
    profiles.each do |profile|
      name = profile[:profile_name].downcase.gsub ' ', '_'
      return profile[:id] if file_components.include? name
    end
    nil
  end

  def find_time_ran(file_components)
    file_components.each do |component|
      begin
        time_ran = component.to_datetime.strftime("%Y-%m-%dT%H:%M")
      rescue
      end
      return time_ran unless time_ran.nil?
    end
    nil
  end

  def store_test_run(report_data:, time_ran:, file_name:, team:, profile:)
    test_runs = TestRun.new
    test_runs.time_ran = time_ran.to_datetime
    test_runs.test_run_name = file_name
    test_runs.team = Team.where(id: team).first
    test_runs.profile = Profile.where(id: profile).first
    test_runs.save
    report_data.each do |feature_data|
      features = store_feature feature_data, team
      feature_data['elements'].each do |scenarios_data|
        scenarios = store_scenario scenarios_data, features
        store_test scenarios_data, scenarios, test_runs
      end
    end
  end

  def store_feature(feature_data, team)
    features = Feature.find_by json_feature_id: feature_data['id']
    if features.nil?
      features = Feature.new
      features.json_feature_id = feature_data['id']
      features.feature_name = feature_data['name']
      features.feature_description = feature_data['description'].strip
      features.team = Team.where(id: team).first
      features.save
    else
      update_feature features, feature_data
    end
    features
  end

  def store_scenario(scenarios_data, features)
    scenarios = Scenario.find_by json_scenario_id: scenarios_data['id']
    if scenarios.nil?
      scenarios = Scenario.new
      scenarios.json_scenario_id = scenarios_data['id']
      scenarios.scenario_name = scenarios_data['name']
      scenarios.scenario_description = scenarios_data['description'].strip
      scenarios.feature = features
      steps = extract_steps scenarios_data['steps']
      scenarios.steps = steps
      scenarios.save
    else
      update_scenario scenarios, scenarios_data
    end
    scenarios
  end

  def store_test(scenarios_data, scenarios, test_runs)
    pass = true
    duration = 0
    error_message = nil
    scenarios_data['steps'].each do |step_data|
      if step_data['result']['status'].eql? 'failed'
        pass = false
        error_message = step_data['result']['error_message']
      end
      unless step_data['result']['status'].eql? 'skipped'
        duration += step_data['result']['duration']
      end
    end

    tests = IndividualTest.new
    tests.passed = pass
    tests.duration = duration
    tests.test_run = test_runs
    tests.scenario = scenarios
    unless error_message.nil?
      errors_message_data = store_error_message error_message
      tests.error_location = errors_message_data[:error_location]
      tests.full_error_message = errors_message_data[:full_error_message]
      tests.error_message = errors_message_data[:error_message]
    end
    tests.save
    tests
  end

  def store_error_message(error_message)
    error_message_data = {full_error_message: error_message}
    message = ''
    error_location = ''
    error_message.split("\n").each do |error|
      if error[0, 2].eql? './'
        error_location += "#{error}\n"
      elsif !error.empty?
        message += "#{error}\n"
      end
    end
    scrubbed_message = scrub_error_message(message)
    error_message_data[:error_location] = error_location
    errors = ErrorMessage.find_by error_message: scrubbed_message
    if errors.nil?
      errors = ErrorMessage.new
      errors.error_message = scrub_error_message(scrubbed_message)
      errors.save
    end
    error_message_data[:error_message] = errors
    error_message_data
  end

  def extract_steps(steps_data)
    steps = ''
    steps_data.each do |step_data|
      steps += step_data['keyword']
      steps += step_data['name'] + "\n"
    end
    steps.strip
  end

  def update_scenario(current_data, new_data)
    new_steps = extract_steps new_data['steps']
    unless current_data.steps.eql? new_steps
      Scenario.update(current_data.id, steps: new_steps)
    end
    new_description = new_data['description'].strip
    unless current_data.scenario_description.eql? new_description
      Scenario.update(current_data.id, scenario_description: new_description)
    end
  end

  def update_feature(current_data, new_data)
    new_description = new_data['description'].strip
    unless current_data.feature_description.eql? new_description
      Feature.update(current_data.id, feature_description: new_description)
    end
  end

  def scrub_error_message(message)
    message.gsub /#<String:[0-9]+>/, '#<String>'
  end
end
