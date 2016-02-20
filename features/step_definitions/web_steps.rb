
Given(/^I visit index page$/) do
  visit '/'
end

Given(/^I visit the sign up page$/) do
  visit '/users/new'
end

Given(/^I visit the request_password_reset page$/) do
  visit '/users/request_password_reset'
end

Given(/^that I visit the reset password page with token "([^"]*)"$/) do |arg1|
  visit('/users/confirm_password_reset/' + arg1)
end

Given(/^there is already a user with username "([^"]*)"$/) do |arg1|
  user = User.create(email: 'sally@email.com', username: arg1, password: '1234', password_confirmation: '1234', password_token: "OOHRAGTNCKSAK")
end

Given(/^there is already a user with email "([^"]*)"$/) do |arg1|
  user = User.create(email: arg1, username: 'Sally', password: '1234', password_confirmation: '1234', password_token: "OOHRAGTNCKSAK")
end

Given(/^I am logged in$/) do
  user = User.create(email: 'sally@email.com', username: 'Sally', password: '1234', password_confirmation: '1234')
  visit '/'
  fill_in 'return_username', with: 'Sally'
  fill_in 'return_password', with: '1234'
  click_on 'Log In'
end

Given(/^I have an account with username "([^"]*)" and password "([^"]*)"$/) do |arg1, arg2|
  user = User.create(email: 'dilbert@email.com', username: arg1, password: arg2, password_confirmation: arg2)
end

Given(/^I am on the index page$/) do
  visit '/'
end

Given(/^that I am not logged in$/) do
  user = User.create(email: 'sally@email.com', username: 'Sally', password: '1234', password_confirmation: '1234')
  visit '/'
  fill_in 'return_username', with: 'Sally'
  fill_in 'return_password', with: '1234'
  click_on 'Log In'
  click_on 'Log Out'
end

Given(/^Sally creates an Onda$/) do
  user = User.create(email: 'sally@email.com', username: 'Sally', password: '1234', password_confirmation: '1234', bio: 'I just love life!', emoji: '👸')
  visit '/'
  fill_in 'return_username', with: 'Sally'
  fill_in 'return_password', with: '1234'
  click_on 'Log In'
  fill_in 'link', with: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
  fill_in 'message', with: 'My Onda'
  fill_in 'tag', with: '#NeverGonnaGiveYouUp'
  fill_in 'artist', with: 'Rick Astley'
  fill_in 'song', with: 'Never gonna give you up'
  click_on 'post'
  click_on 'Log Out'
end

Given(/^Billy creates an Onda$/) do
  user = User.create(email: 'billy@email.com', username: 'Billy', password: '1234', password_confirmation: '1234')
  visit '/'
  fill_in 'return_username', with: 'Billy'
  fill_in 'return_password', with: '1234'
  click_on 'Log In'
  fill_in 'link', with: 'https://www.youtube.com/watch?v=4B2a6l6wM2k'
  fill_in 'message', with: 'Check this guy out!!!'
  fill_in 'tag', with: 'adamant #itisapun'
  fill_in 'artist', with: 'adamant'
  fill_in 'song', with: 'Stand And Deliver'
  click_on 'post'
  click_on 'Log Out'
end

Given(/^I am on the profile page of "([^"]*)"$/) do |arg1|
  user = User.create(email: 'sally@email.com', username: 'Sally', password: '1234', password_confirmation: '1234', bio: 'I just love life!')
  visit "/users/#{arg1}"
end

Given(/^it is "([^"]*)"$/) do |arg1|
  Timecop.freeze(2015, 8, 27, 12, 0, 0, "+01:00")
end

When(/^I visit the home page$/) do
  visit '/'
end


When(/^I click the "([^"]*)" button$/) do |arg1|
  click_on arg1
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |arg1, arg2|
  fill_in arg1, with: arg2
end

When(/^I make an Onda$/) do
  fill_in 'link', with: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
  fill_in 'message', with: 'My Onda'
  fill_in 'tag', with: '#NeverGonnaGiveYouUp'
  fill_in 'artist', with: 'Rick Astley'
  fill_in 'song', with: 'Never gonna give you up'
  click_on 'post'
end

When(/^I click on "([^"]*)"$/) do |arg1|
  click_on arg1
end

Then(/^I should see "([^"]*)"$/) do |arg1|
  expect(page).to have_content(arg1)
end

Then(/^I can see an Onda$/) do
  expect(page).to have_content('My Onda')
end

Then(/^I should visit "([^"]*)"$/) do |arg1|
  expect(current_url).to eq(arg1)
end


Then(/^I should not see "([^"]*)"$/) do |arg1|
  expect(page).not_to have_content(arg1)
end

Then(/^I should be on path "([^"]*)"$/) do |arg1|
  expect(current_path).to eq arg1
end

When(/^I click "([^"]*)"$/) do |arg1|
  click_on 'Submit Phrase'
end

Given(/^I have entered the phrase "([^"]*)"$/) do |arg1|
  visit '/'
  fill_in "phrase", with: arg1
  fill_in "syllables", with: "1"
end

When(/^I enter "([^"]*)" in "([^"]*)"$/) do |arg1, arg2|
  visit '/'
  fill_in "syllable pattern", with: :pending # Write code here that turns the phrase above into concrete actions
end
