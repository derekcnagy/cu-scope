# Reports

### Report Filter
  ##### From Date
    Filter out test runs after this date. 
    Defaults to todays date.  
  ##### To Date
    Filter out test runs before this date.
    Defaults to 30 days ago.
  ##### Team
    Will only pull test runs from selected team.
    Defaults to the user's team, or no team.
  ##### Profile
    Will only pull test runs from selected profile.
    Defaults to the user's selected defualt profile team, or no profile.

### Report
  ##### Features
    Name of the test's feature. Clicking will show the feature's description.
  ##### Scenarios
    Name of the test's scenario. Clicking will show the scenario's description and step definition.
  ##### Date
    The date of the test run.
  ##### Passing Test
    Passing tests are colored green. Clicking will show the run duration. 
  ##### Failing Test
    Failing tests are colored red. Clicking will show the run duration, error message, notes, and the add note button.
  ##### Duration
    How long the test took to run in seconds. Click test to see.
  ##### Error Message
    Only Failed Tests.
    The test's error message. Click failed test to see.
  ##### Notes
    Users of Cu-Scope can make notes on failed tests. A note can apply to just one test, any test of a scenario with the same
    error message, or any error message of any scenario for a team.
  ##### Add Note
    Added a new note to the failed test. the new note can apply to just the selected test, any test of a test's scenario with
    the same error message, or any error message of any scenario for a team.


# Analytics
### Analytics Filter
  ##### From Date
    Filter out data from test runs after this date. 
    Defaults to todays date.  
  ##### To Date
    Filter out data from test runs before this date.
    Defaults to 30 days ago.
  ##### Team
    Will only pull data from selected team.
    Defaults to the user's team, or no team.
    
### Most Failed Scenarios
  List all the scenarios for selected team and show how often they fail. Ordered failing most offten to lest offten.
  ##### Scenario
    Name of the scenario
  ##### Failed Percent
    How often the scenario fails as a percentage. The more offten the scenario fails the redder this becomes.
### Longest Running Tests
  List all the scenarios for selected team and show how long they they run on average and how that compares to average of all the teams scenarios. Ordered longest running to shortest running.
  ##### Scenario
    Name of the scenario
  ##### Duration
    How long the scenario runs on average, in seconds.
  ##### Compared To Average
    How the scenario's average run time compares to all scenarios of the selected team, as a percentage. The long the run is compared to the average the redder it is, the shorter the run is compared to the average is the greener it is.  
### Most Common Errors
  List all the errors that failed tests had, and how offten that they occured. Ordered most offten occurring to lest offten.
  ##### Error Message
    The error message
  ##### Error Count
    How offten the error occured
# Add Report
# Teams
# Profiles
# Test Runs
# Notes
# Users
# Settings
