Feature: Login

  Scenario: Login with wrong data
    When I go to "https://viktor-silakov.github.io/course-sut/?quick"
    Then I get error, when login as:

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
