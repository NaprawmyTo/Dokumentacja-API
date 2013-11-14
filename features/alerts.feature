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
      | id   | username | password | email              |
      | 1324 | konrad   | KPASS    | konrad@example.com |
      | 2424 | piotr    | PPASS    | piotr@example.com  |
    And users have following refresh tokens:
      | konrad > KONRAD_REFRESH_TOKEN_1 |
      | piotr > PIOTR_REFRESH_TOKEN_1   |
    And users have following access tokens:
      | konrad > KONRAD_ACCESS_TOKEN_1 |
      | piotr > PIOTR_ACCESS_TOKEN_1   |
    And there are following alerts defined:
      | id | long | lat  | description                                                 |
      | 1  | 19.5 | 50.5 | There is a big hole in the middle of nowhere (Tar District) |
      | 2  | 21.5 | 51.5 | Serious alert about some serious issue (Foo District)       |
      | 3  | 21.6 | 51.7 | Second alert about some other serious issue (Foo District)  |
    And alerts have following categories:
      | 1 > Hole in road    |
      | 1 > Dangerous place |
      | 2 > Hole in road    |
      | 2 > Dangerous place |
      | 2 > Broken window   |
      | 3 > Broken lights   |

  Scenario Outline: Adding new alert as anonymous user
    Given that I am not using cookies
    And that I want to make a new request
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
    And that I want to make a new request
    And that its parameter "access_token" is "<access_token>"
    And that its parameter "long" is "<long>"
    And that its parameter "lat" is "<lat>"
    And that its parameter "district_id" is "<district_id>"
    And that its parameter "description" is "<description>"
    When I request "/api/v3/alerts" using "POST" method
    Then the response status code is "<status_code>"

  Examples:
    | username | access_token          | long | lat  | district_id | description                                    | status_code |
    | konrad   | KONRAD_ACCESS_TOKEN_1 | 21   | 52   | 43          | First alert in Foo district                    | 201         |
    | konrad   | KONRAD_ACCESS_TOKEN_1 | 21.5 | 51.5 | 43          | Second alert in Foo district                   | 201         |
    | konrad   | KONRAD_ACCESS_TOKEN_1 | 21.5 | 51.5 | 999         | Alert in district that doesn't exist in system | 400         |


  Scenario Outline: Fetch information about an Alert
    Given that I am not using cookies
    When I request "/api/v3/alerts/<id>" using "GET" method
    Then the response status code is "200"
    And I should get json response that contains:
      | id   | long   | lat   | description   |
      | <id> | <long> | <lat> | <description> |
  Examples:
    | id | long | lat  | description                                                 |
    | 1  | 19.5 | 50.5 | There is a big hole in the middle of nowhere (Tar District) |
    | 2  | 21.5 | 51.5 | Serious alert about some serious issue (Foo District)       |

  Scenario Outline: Fetch information about Alert categories
    Given that I am not using cookies
    When I request "/api/v3/alerts/<id>/categories" using "GET" method
    Then the response status code is "200"
    And the response body should contain "<categories_count>" categories
  Examples:
    | id | categories_count |
    | 1  | 2                |
    | 2  | 3                |
    | 3  | 1                |



