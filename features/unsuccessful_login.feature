Feature: Login

  Scenario: Login with wrong user data
    When I go to "https://viktor-silakov.github.io/course-sut/?quick"
    Then I get "Fail to login" message, when login as:

      | username                 | password     |
      | walker@jw.com            | password1    |
      | admin                    | admin        |
      | user                     | 123          |
      | dlink                    | dlink        |
      | password                 | walker@jw.com|

  Scenario: Login with empty password
    When I go to "https://viktor-silakov.github.io/course-sut/?quick"
    Then I get "Password is empty" message, when login as:

      | username                 | password     |
      | walker@jw.com            |              |
      | user                     |              |
      | admin                    |              |
  
  Scenario: Login with empty username
    When I go to "https://viktor-silakov.github.io/course-sut/?quick"
    Then I get "Login is empty" message, when login as:

      | username                 | password     |
      |                          | password     |
      |                          |              |
  
   Scenario: Login as blocked user
    When I go to "https://viktor-silakov.github.io/course-sut/?quick"
    Then I get "The user is suspended" message, when login as:

      | username                 | password     |
      | old_walker@jw.com        | password1    |
