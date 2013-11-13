Feature: Scenarios for alerts api endpoint

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

  Scenario Outline: Adding new alert as anonymous user
    Given that I am not authenticated
    And that I want to make a new "Alert"
    And that its parameter "long" is "<long>"
    And that its parameter "lat" is "<lat>"
    And that its parameter "district_id" is "<district_id>"
    And that its parameter "description" is "<description>"
    When I request "/api/v3/alerts"
    Then the response status code is "<status_code>"

  Examples:
    | long | lat  | district_id | description                                    | status_code |
    | 21   | 52   | 43          | First alert in Foo district                    | 201         |
    | 21.5 | 51.5 | 43          | Second alert in Foo district                   | 201         |
    | 21.5 | 51.5 | 999         | Alert in district that doesn't exist in system | 400         |

  Scenario Outline: Adding new alert as authenticated user
    Given that I am authenticated as "konrad"
    And that I want to make a new "Alert"
    And that its parameter "long" is "<long>"
    And that its parameter "lat" is "<lat>"
    And that its parameter "district_id" is "<district_id>"
    And that its parameter "description" is "<description>"
    When I request "/api/v3/alerts"
    Then the response status code is "<status_code>"

  Examples:
    | long | lat  | district_id | description                                    | status_code |
    | 21   | 52   | 43          | First alert in Foo district                    | 201         |
    | 21.5 | 51.5 | 43          | Second alert in Foo district                   | 201         |
    | 21.5 | 51.5 | 999         | Alert in district that doesn't exist in system | 400         |

