Feature: borrower mock server

 # Scenario: pathMatches('/services/apexrest/v3/borrower/status/') && methodIs('get') && paramExists('borrowerExternalId') && paramExists('aggregatorID')
  #  * def responseStatus = 200
  #  * def response = read('classpath:examples/data/approved.json')



  Scenario: pathMatches('/services/apexrest/v3/borrower/status/') && methodIs('get') && paramValue('borrowerExternalId') == '100'
    * def responseStatus = 200
    * def responser = read('classpath:data/approved.json')
    * set responser.code = "Pending"
    * set responser.description = "End-user has completed the initial registration on the Butn Platform"
    * def response = responser
    * print responser
    * print response

  Scenario: pathMatches('/services/apexrest/v3/borrower/status/') && methodIs('get') && paramValue('borrowerExternalId') == '101'
    * def responseStatus = 200
    * def responsei = read('classpath:data/approved.json')
    * set responsei.code = "Pending (Login Created)"
    * set responsei.description = "End-user has verified their details and activated their account on the Butn Platform"
    * def response = responsei
    * print responsei
    * print response

# catch all scenario
  Scenario:
    * print 'No dedicated scenario matches incoming request.'
    * print 'With Headers:'
    #* print requestHeaders
    * print 'With Request Parameters'
   # * print requestParams
    * print 'And Request:'
    #* print request