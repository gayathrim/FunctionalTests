Feature: As an android app user, I want to create my profile.

#create profile
@android @high @smoke
Scenario: Verify on successful profile creation, user is automatically logged in. New profile created event is shown in the timeline.
  Given Qloud gives success response for creating account "gayathri@gmail.com"

  Given I open the app and land on home screen
  When I navigate to Profile tab
  Then I should see the profile home screen
  Then I should see below text in create profile section
    | createProfileText |
    | Start your journey |
    | Share your creations, collect badges and earn awesome loyalty gifts. |
  Then I should see below text in login profile section
    | loginProfileText |
    | Log in and more  |
    | Are you already a member of the Cloud world? Log in here. |
  When I go to create Profile section
  And I create my profile with
    | Email              | Password  | Accept_terms_conditions  |
    | gayathri@gmail.com | 123456789 | true                    |
  Then I should get a confirmation pop up saying "Confirmation email sent! Please verify your email account."
  And I am on my personal profile page
  Then my timeline events are shown as below:
    | Timeline_Events |
    | You've created your profile |

@wip @high
Scenario: Verify when user has not entered email id or password or not accepted T&C,then create profile button shld be disabled.

@wip @high
Scenario: Verify when user enters an invalid email address,then "Invalid email format" message is dispalyed.
