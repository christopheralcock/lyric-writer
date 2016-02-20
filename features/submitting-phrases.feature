Feature: Submitting phrases
  In order to create lyrics
  As a visitor to the web app
  I want to input phrases

  Scenario: inputting a phrase
    When I visit the home page
    Then I should see "Please tell me a phrase you want to incorporate in your lyrics"

  Scenario: submitting a phrase
    Given I have not entered a single-syllable phrase
    When I click "Submit Phrase"
    Then I should see "You need at least one single-syllable phrase"
