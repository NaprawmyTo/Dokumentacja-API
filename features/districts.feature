Feature: Scenarios for districts api endpoint

  Background:
    Given there are following districts defined:
      | id | name         |
      | 43 | Foo District |
      | 72 | Bar District |
    And there are following categories defined:
      | id | name            |
      | 10 | Hole in road    |
      | 17 | Dangerous place |
      | 32 | Broken window   |

    And districts have following categories:
      | Foo District > Hole in road    |
      | Foo District > Dangerous place |
      | Bar District > Hole in road    |
      | Bar District > Dangerous place |
      | Bar District > Broken window   |
    And there are following users defined:
      | id   | username | email              |
      | 1324 | konrad   | konrad@example.com |
      | 2424 | piotr    | piotr@example.com  |

  Scenario Outline: Fetch information about district
    Given I am not authenticated user
    When I go to "/api/v3/districts/<id>"
    Then I should json response that contains:
      | id   | name   |
      | <id> | <name> |
    And the response status code is "<status_code>"

  Examples:
    | id  | name         | status_code |
    | 43  | Foo District | 200         |
    | 72  | Bar District | 200         |

  Scenario: Fetch information about district that doesn't exist
    Given I am not authenticated user
    When I go to "/api/v3/districts/999"
    Then the response status code is "404"
    And the response body is empty