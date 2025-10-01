Feature: Delete user

  Background:
    * url 'https://gorest.co.in/public/v2'
    * header Authorization = 'Bearer 700d0c7a86eb84028bf5cd204b11587f812f9d7cd880dc4edbdbd1d407ae9954'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'

  Scenario: Delete user by userId
    # userId viene desde el call
    Given path 'users', userId
    When method delete
    Then status 204
    * print 'Deleted userId:', userId