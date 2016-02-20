Feature: Generating lyrics
  In order to create lyrics
  As a visitor to the web app
  I want to generate lyrics

  Scenario: generating lyrics
    Given I have entered the phrase "test" with the syllable count "1"
    And I click "Submit Phrase"
    Then I should see "test test test test test test test"
