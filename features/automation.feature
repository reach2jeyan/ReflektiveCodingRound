Feature: Reflective Coding round

  Scenario: Help Karan reach the payment gateway and calculate his expenses
    Given I go to cleartrip website
    And I choose round trip
    Then I enter "Bangalore" in the from and "Delhi" in the destination
    Then I choose the date to two weeks from now and return the next day
    And I enter other details and wait for the flight options
    Then I choose the cheapest nonstrop flight and book the last flight the next day
    And I book the flight
    Then I go to amazon website
    And I search for the book "A Brief History of Everyone Who Ever Lived"
    Then I purchase the book
    And I wait for the payment page
    And I print the total expenditure for this trip to karan
