Feature: Login

  Scenario: Login with wrong data
    When I go to "https://viktor-silakov.github.io/course-sut/?quick"
    Then I get error, when login as:

<<<<<<< HEAD
      | username                 | password     | message               |
      | walker@jw.com            | password1    | Fail to login         |
      | admin                    | admin        | Fail to login         |
      | user                     | 123          | Fail to login         |  
      | dlink                    | dlink        | Fail to login         |
      | password                 | walker@jw.com| Fail to login         |
      | walker@jw.com            |              | Password is empty     |
      | user                     |              | Password is empty     |
      | admin                    |              | Password is empty     |
      |                          | password     | Login is empty        |
      |                          |              | Login is empty        |
      | old_walker@jw.com        | password1    | The user is suspended |
=======
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
>>>>>>> 41310bef0d292c94684feae53b8532e271e0fc42
