Feature: Authenticating with api

  Background:
    Given there are following users defined:
      | id   | username | password | email              |
      | 1324 | konrad   | KPASS    | konrad@example.com |
      | 2424 | piotr    | PPASS    | piotr@example.com  |
    And users have following refresh tokens:
      | konrad > KONRAD_REFRESH_TOKEN_1 |
      | piotr > PIOTR_REFRESH_TOKEN_1   |
    And users have following access tokens:
      | konrad > KONRAD_ACCESS_TOKEN_1 |
      | piotr > PIOTR_ACCESS_TOKEN_1   |

  Scenario Outline: Fetch new access token using username and password
    Given that I am not using cookies
    And that there is an account with username "<username>" and password "<password>"
    And that I want to make a new request
    And that its parameter "username" is "<username>"
    And that its parameter "password" is "<password>"
    When I request "/api/v3/token" using "POST" method
    Then the response status code is "200"
    And I should get json response that contains:
      | access_token   | expires_in   | refresh_token   |
      | <access_token> | <expires_in> | <refresh_token> |

  Examples:
    | username | password | access_token          | expires_in | refresh_token          |
    | konrad   | KPASS    | KONRAD_ACCESS_TOKEN_1 | 3600       | KONRAD_REFRESH_TOKEN_1 |


  Scenario Outline: Fetch new access token using refresh token
    Given that I am not using cookies
    And that there is an account with username "<username>" and password "<password>"
    And that I want to make a new request
    And that its parameter "refresh_token" is "<refresh_token>"
    When I request "/api/v3/token" using "POST" method
    Then the response status code is "200"
    And I should get json response that contains:
      | access_token   | expires_in   | refresh_token   |
      | <access_token> | <expires_in> | <refresh_token> |

  Examples:
    | username | password | access_token          | expires_in | refresh_token          |
    | konrad   | KPASS    | KONRAD_ACCESS_TOKEN_1 | 3600       | KONRAD_REFRESH_TOKEN_1 |
    | piotr    | PPASS    | PIOTR_REFRESH_TOKEN_1 | 3600       | PIOTR_REFRESH_TOKEN_1  |

  Scenario: Passing both password and refresh toke at the same time
  One shouldn't pass both password and refresh_token in the same request
    Given that I am not using cookies
    And that there is an account with username "konrad" and password "XXXX"
    And that I want to make a new request
    And that its parameter "username" is "konrad"
    And that its parameter "password" is "XXXX"
    And that its parameter "refresh_token" is "YYY1"
    When I request "/api/v3/token" using "POST" method
    Then the response status code is "400"
