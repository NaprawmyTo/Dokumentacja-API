Feature: Scenarios for districts api endpoint

  Background:
    Given there are following districts defined:
      | id | name         | area                              |
      | 43 | Foo District | ((51,21),(52,21),(52,22),(51,22)) |
      | 72 | Bar District | ((52,20),(53,20),(53,21),(52,21)) |
      | 85 | Tar District | ((50,19),(51,19),(51,20),(50,20)) |
    And there are following categories defined:
      | id | name            |
      | 10 | Hole in road    |
      | 17 | Dangerous place |
      | 32 | Broken window   |
      | 40 | Broken lights   |
    And districts have following categories:
      | Foo District > Hole in road    |
      | Foo District > Dangerous place |
      | Bar District > Hole in road    |
      | Bar District > Dangerous place |
      | Bar District > Broken window   |
      | Tar District > Broken lights   |
    And there are following users defined:
      | id   | username | email              |
      | 1324 | konrad   | konrad@example.com |
      | 2424 | piotr    | piotr@example.com  |

  Scenario Outline: Fetch information about district
    Given I am not authenticated user
    When I request "/api/v3/districts/<id>" using "GET" method
    Then I should get json response that contains:
      | id   | name   |
      | <id> | <name> |
    And the response status code is "<status_code>"

  Examples:
    | id | name         | status_code |
    | 43 | Foo District | 200         |
    | 72 | Bar District | 200         |

  Scenario: Fetch information about district that doesn't exist
    Given I am not authenticated user
    When I request "/api/v3/districts/999" using "GET" method
    Then the response status code is "404"
    And the response body is empty

  Scenario Outline: Fetch categories from given District
    When I request "/api/v3/districts/<district_id>/categories" using "GET" method
    Then the response status code is "200"
    And the response body should contain "<categories_count>" categories
  Examples:
    | district_id | categories_count |
    | 43          | 2                |
    | 72          | 3                |
    | 85          | 1                |