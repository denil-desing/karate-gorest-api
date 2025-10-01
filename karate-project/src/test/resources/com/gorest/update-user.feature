Feature: Update user

  Background:
    * url 'https://gorest.co.in/public/v2'
    * header Authorization = 'Bearer 700d0c7a86eb84028bf5cd204b11587f812f9d7cd880dc4edbdbd1d407ae9954'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'

  Scenario: Update user by userId
    # userId viene desde el call
    * def uuidUpdate = java.util.UUID.randomUUID().toString().replaceAll('-', '')
    * def emailUpdate = 'allasani.peddana.' + uuidUpdate + '@example.com'

    Given path 'users', userId
    And request
    """
    {
      "name": "Allasani Peddana",
      "email": "#(emailUpdate)",
      "status": "active"
    }
    """
    When method patch
    Then status 200
    And match response contains { name: "Allasani Peddana", status: "active" }
    * print 'Updated userId:', userId
