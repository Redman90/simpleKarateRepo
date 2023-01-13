Feature: borrower status call

  Background:
    * def token = 'foo'
    * header Authorization = 'Bearer ' + token
    * def start = () => karate.start('BorrowerMock.feature').port
    * def port = callonce start
    * url 'http://localhost:' + port
    * def expectedOutput = read('classpath:data/approved.json')

  Scenario Outline: Verify each stage of the application.  This assumes you have your test data set up in your
  environment (aggregatorID's and borrowerExternalId's for each stage)


    Given path '/services/apexrest/v3/borrower/status/'
    And param borrowerExternalId = <borrowerExternalId>
    And param aggregatorID = <aggregatorId>
    When method get
    Then status 200
    And print expectedOutput
    And print response
    And print response.code
    And print response.description
    #And match response == expectedOutput
    And match response.description == <Description>
    And match response.code == <Code>


    Examples:
      | aggregatorId | borrowerExternalId |Code                           |Description                                                                                                                      |
      | '12345'      | '100'              |'Pending'                      |'End-user has completed the initial registration on the Butn Platform'                                                           |
      | '12345'      | '101'              |'Pending (Login Created)'      |'End-user has verified their details and activated their account on the Butn Platform'                                           |
      | '12345'      | '102'              |'Review'                       |'End-user account has been flagged for review; Reason: [review reason]'                                                          |
      | '12345'      | '103'              |'Will not fund'                |'End-user account has been declined and marked as Will not fund. The account cannot be used to transact on the Butn Platform.'   |
      | '12345'      | '104'              |'Approved'                     |'End-user account has been approved and is ready to transact on the Butn Platform'                                              |
      | '12345'      | '105'              |'Inactive – Ineligible'        |'End-user account has been deactivated and cannot be reinstated without manual intervention.'                                    |
      | '12345'      | '106'              |'Inactive –[suspended]'        |'End-user account has been deactivated and can be reinstated.'                                                                   |
      | '12345'      | '107'              |'Inactive –[Unsubscribed]'     |'End-user has verified their details and activated their account on the Butn Platform'                                           |
      | '12345'      | '108'              |'Not Applicable'               |'An End-user with the provided key does not exist.'                                                                              |


  Scenario: request with blank aggregatorID returns 400
    Given path '/services/apexrest/v3/borrower/status/'
    When method get
    And param aggregatorID = ""
    And param borrowerExternalId = 12345
    Then status 400
    And response.errorCode == "BAD_REQUEST"
    And response.message == "Param: Aggregator ID or Borrower External ID was blank."


  Scenario: request with blank borrowerExternalID returns 400
    Given path '/services/apexrest/v3/borrower/status/'
    When method get
    And param aggregatorID = 123
    And param borrowerExternalId = ""
    Then status 400
    And response.errorCode == "BAD_REQUEST"
    And response.message == "Param: Aggregator ID or Borrower External ID was blank."

  Scenario: request with blank aggregatorID and blank borrowerExternalID returns 400
    Given path '/services/apexrest/v3/borrower/status/'
    When method get
    And param aggregatorID = ""
    And param borrowerExternalId = ""
    Then status 400
    And response.errorCode == "BAD_REQUEST"
    And response.message == "Param: Aggregator ID or Borrower External ID was blank."

  Scenario: request with borrowerExternalID that does not match returns 400
    Given path '/services/apexrest/v3/borrower/status/'
    When method get
    And param aggregatorID = "1234"
    And param borrowerExternalId = "1234892"
    Then status 400
    And response.message == "Invalid aggregatorId! You are NOT authorised to transact against this aggregatorId. Please contact Butn to verify you have received the correct aggregatorId - it is mandatory for every api call to the Butn Platform."

