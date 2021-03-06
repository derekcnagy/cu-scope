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
  Only averable for Contributors and Admins.
### Files to Process
  ##### File Name
    Name of the File to process.
  ##### Time Ran
    The Time the test run of the file ran. If a timestamp is in the file name this field will default to that.
  ##### Team 
    Name of the team the file is for. If a team name is in the file name this field will default to that.
  ##### Profile
    Name of the profile the file is for. If a profile name is in the file name this field will default to that.
  ##### Process
    Click to process the file.
    
### Upload File
  New run files can be uploaded from here.
  
### File Formatting 
    If you want the time ran, team, and profile to auto-fill put dashes(-) between them in the file name. Order dose not matter. 
    Examples: 
      20190220013954-my_team-a_profile.json
# Teams
Only available for Admins.

###### Team Name
    Name of the team, can be changed
###### Rename Team
    Will save the team name as what you changed it to.
###### Delete Team
    Deletes the team.
###### Add Team
    Creates a new team.
# Profiles
Only averable for Admins.

###### Profile Name
    Name of the profile, can be changed
###### Rename Profile
    Will save the profile name as what you changed it to.
###### Delete Profile
    Deletes the profile.
###### Add Profile
    Creates a new profile
# Test Runs
Only available for Admins.

##### Test Run Name	
   Name of the file the test run was uploaded from.
##### Time Ran	
  The time the test run ran.
##### Team	
  Name of the team the test run is for.
##### Profile	
  Name of the profile the test run is for.
##### Delete
  Deletes the test run.

# Notes
Only available for Admins and Contributor.
### Notes Filter
  ##### From Date
    Filter out notes from test runs after this date. 
    Defaults to todays date.  
  ##### To Date
    Filter out notes from test runs before this date.
    Defaults to 30 days ago.
  ##### Team
    Will only pull notes from selected team.
    Defaults to the user's team, or no team.
    
### Notes for Scenarios
##### Note	
    The Text of the Note.
##### Feature	
    The name of the feature of the scenario the note is for. 
##### Scenario	
    The name of the scenario the note is for.
##### Error Message	
    The error message the note is for.
##### Last Date Invoked	
    The date of the most recent test run the note was invoked.
##### Date Created	
    The date the note was created.
##### Delete
    Deletes the note.

### Notes for Error Message
##### Note	
    The Text of the Note.
##### Error Message	
    The error message the note is for.
##### Last Date Invoked	
    The date of the most recent test run the note was invoked.
##### Date Created	
    The date the note was created.
##### Delete
    Deletes the note.

### Notes for Individual Test
##### Note	
    The Text of the Note.
##### Time Ran	
    The date of the test run the note is for.
##### Feature	
    The name of the feature of the scenario the note is for. 
##### Scenario	
    The name of the scenario the note is for.
##### Error Message	
    The error message the note is for.
##### Date Created	
    The date the note was created.
##### Delete  
    Deletes the note.

# Users
Only available for Admins.
##### Username	
  The user's username. Can be changed.
##### First Name	
  The user's first name. Can be changed.
##### Last Name	
  The user's last name. Can be changed.
##### Team	
  The user's team. Can be changed.
##### User Type	
  The user's user type. Can be changed.
##### Update User	
  Will save the changes you made to the user. 
##### Reset Password	
  Will reset the users password. New password will be displayed above the table.
##### Delete User
  Will Delete the user


# Settings
