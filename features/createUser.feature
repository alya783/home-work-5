Feature: User Creation

  Background:
    When I go to "https://viktor-silakov.github.io/course-sut/"
    And I login as: "walker@jw.com", "password" 

  Scenario: Create user
    When I go to "Create User" menu item
    And I fill form:
      """
      email: 'test@test.com'
      password: 'U&cmpYsxK9'
      address1: 'Rustaveli 20-21'
      address2: 'flor 4'
      city: 'Tbilisi'
      zip: '222567'
      description: 'test user'
      """
    Then I check new user
