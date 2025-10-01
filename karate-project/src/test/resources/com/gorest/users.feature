Feature: Gorest API - Users

  Background:
    * url 'https://gorest.co.in/public/v2'
    * header Authorization = 'Bearer 700d0c7a86eb84028bf5cd204b11587f812f9d7cd880dc4edbdbd1d407ae9954'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'

  Scenario: List users
    Given path 'users'
    When method get
    Then status 200
    And match response != null
    * assert response.length > 0
    * print 'Number of users:', response.length

  Scenario: Create user
    # --------------------
    # CREATE
    # --------------------
    * def uuidCreate = java.util.UUID.randomUUID().toString().replaceAll('-', '')
    * def emailCreate = 'tenali.ramakrishna.' + uuidCreate + '@example.com'

    Given path 'users'
    And request
    """
    {
      "name": "Tenali Ramakrishna",
      "gender": "male",
      "email": "#(emailCreate)",
      "status": "active"
    }
    """
    When method post
    Then status 201
    * match response contains { name: "Tenali Ramakrishna", gender: "male", status: "active" }
    * assert response.email == emailCreate
    * def userId = response.id
    * print 'Created userId:', userId

    # --------------------
    # UPDATE usando call a otro feature
    # --------------------
    * def result = call read('update-user.feature') { userId: userId }

    # --------------------
    # DELETE
    # --------------------
    * def resultDelete = call read('delete-user.feature') { userId: userId }
