Feature: Authenticating with api

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
    | username | password | access_token | expires_in | refresh_token |
    | konrad   | XXXX     | YYYY         | 3600       | ZZZZ          |


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
    | username | password | access_token | expires_in | refresh_token |
    | konrad   | XXXX     | YYY1         | 3600       | ZZZ1          |
    | piotr    | XXXX     | YYY2         | 3600       | ZZZ2          |


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
