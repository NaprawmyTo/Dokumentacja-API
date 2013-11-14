Feature: Authenticating with api

  Scenario Outline: Fetch new access token using username and password
    Given I am not using cookies
    And I have account with username "<username>"
    And My password is "<password>"
    And I want to authenticate with api
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
    Given I am not using cookies
    And I have account with username "<username>"
    And I want to authenticate with api
    And that its parameter "refresh_token" is "<refresh_token>"
    When I request "/api/v3/token" using "POST" method
    Then the response status code is "200"
    And I should get json response that contains:
      | access_token   | expires_in   | refresh_token   |
      | <access_token> | <expires_in> | <refresh_token> |

  Examples:
    | username | access_token | expires_in | refresh_token |
    | konrad   | YYY1         | 3600       | ZZZ1          |
    | piotr    | YYY2         | 3600       | ZZZ2          |


  Scenario: Passing both password and refresh token TODO