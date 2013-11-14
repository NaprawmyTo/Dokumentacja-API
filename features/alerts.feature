Feature: Scenarios for alerts api endpoint

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
    And there are following alerts defined:
      | id | long | lat  | description                                                 |
      | 1  | 19.5 | 50.5 | There is a big hole in the middle of nowhere (Tar District) |
      | 2  | 21.5 | 51.5 | Serious alert about some serious issue (Foo District)       |

  Scenario Outline: Adding new alert as anonymous user
    Given that I am not authenticated
    And that I want to make a new "Alert"
    And that its parameter "long" is "<long>"
    And that its parameter "lat" is "<lat>"
    And that its parameter "district_id" is "<district_id>"
    And that its parameter "description" is "<description>"
    When I request "/api/v3/alerts" using "POST" method
    Then the response status code is "<status_code>"

  Examples:
    | long | lat  | district_id | description                                     | status_code |
    | 21.3 | 51.2 | 43          | New alert in Foo district                       | 201         |
    | 21.6 | 51.4 | 43          | New alert in Foo district                       | 201         |
    | 21.5 | 51.5 | 999         | Alert in district that doesn't exist in system  | 400         |
    | 19.5 | 41.5 | 43          | Alert that is located outside of given district | 400         |

  Scenario Outline: Adding new alert as user
    Given that I have valid access token "<access_token>" assigned to user "<username>"
    And that I want to make a new "Alert"
    And that its parameter "access_token" is "<access_token>"
    And that its parameter "long" is "<long>"
    And that its parameter "lat" is "<lat>"
    And that its parameter "district_id" is "<district_id>"
    And that its parameter "description" is "<description>"
    When I request "/api/v3/alerts" using "POST" method
    Then the response status code is "<status_code>"

  Examples:
    | username | access_token | long | lat  | district_id | description                                    | status_code |
    | konrad   | XXX          | 21   | 52   | 43          | First alert in Foo district                    | 201         |
    | konrad   | XXX          | 21.5 | 51.5 | 43          | Second alert in Foo district                   | 201         |
    | konrad   | XXX          | 21.5 | 51.5 | 999         | Alert in district that doesn't exist in system | 400         |

