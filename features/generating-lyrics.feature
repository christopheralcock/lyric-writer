Feature: Generating lyrics
  In order to create lyrics
  As a visitor to the web app
  I want to generate lyrics

  Scenario: generating lyrics
    Given I have entered the phrase "test"
    When I enter "4 3" in "Syllable pattern"
    And I click "Generate lyrics"
    Then I should see "test test test test test test test"
