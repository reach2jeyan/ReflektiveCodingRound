require 'date'
require 'watir'
require 'rspec'
require 'watir-scroll'
require 'yaml'
require_relative '../../features/support/env'
load = YAML::load_file('testdate.yml')



And(/^I enter "([^"]*)" in the from and "([^"]*)" in the destination$/) do |arg1, arg2|
  $browser.element(:id, load['identifiers']['From'].to_s).send_keys(arg1)
  $browser.element(:id, load['identifiers']['Destination'].to_s).send_keys(arg2)

end

And(/^I choose round trip$/) do
  $browser.element(:id, 'RoundTrip').click
end

Then(/^I choose the date to two weeks from now and return the next day$/) do
  $browser.div(:class , 'span span15 datePicker').click
  date = Date.today
  addtwoweeks = date + 14
  newdate = addtwoweeks.day
  $browser.a(:class => 'ui-state-default' , :text => newdate.to_s).click
  returndate = newdate + 1
  sleep 5
  #$browser.a(:class => 'ui-state-default' , :index => 1).click
  $browser.a(:class => 'ui-state-default' , :text => returndate.to_s).click

end

And(/^I enter other details and wait for the flight options$/) do
  $browser.element(:id =>'Childrens').click
  sleep 3
  $browser.element(:value => 2.to_s).click
  $browser.element(:id, 'SearchBtn').click
  sleep 15
  $browser.div(:class , 'searchSummary').wait_until_present
end

Then(/^I choose the cheapest nonstrop flight and book the last flight the next day$/) do
  listofprices = []
  departure = []
  $browser.elements(:css => '.colZero.leg.col12:not(.last) .price').each do |div|   #Choose the elements matching the class of the css that represents price. Since the class of from and return journey prices are same, seperate the last price with not css
    listofprices << div.text
  end
  listofprices.delete('Price')
  $cheapestflight = listofprices.min
  puts "Choosing the cheapest flight priced at #{$cheapestflight}"
  $browser.element(:text, $cheapestflight).when_present.click
  sleep 6
  $browser.scroll.to :center
  $browser.elements(:css => '.colZero.leg.col12.last .depart').each do |div|
    departure << div.text
  end
  departure.delete('Depart')
  puts "Choosing the last flight scheduled to depart at #{departure.max}"
  $browser.element(:text, departure.max.to_s).when_present.click

end

And(/^I book the flight$/) do
  $browser.scroll.to :top
  $totaltripcost = $browser.h2(:class , 'totalAmount').text
  $browser.button(:text => 'Book').fire_event('onclick')
  puts "Stuck at initiate booking page with url #{$browser.url}. Kindly take on from here"
end

And(/^I search for the book "([^"]*)"$/) do |arg|
  $nameofthebook = arg
  $browser.input(:id, 'twotabsearchtextbox').send_keys(arg)
  $browser.input(:value, 'Go').click
end

Then(/^I purchase the book$/) do
  $browser.a(:text, 'A Brief History of Everyone Who Ever Lived').when_present.click
  $browser.window(index: 1).use do #Since the browser title is too long to switch window by title
    $browser.elements(:css => '.a-size-medium.a-color-price.inlineBlock-display.offer-price.a-text-normal.price3P').each do |div|
      $costofbook = div.text
    end
    $browser.span(:id, 'a-autoid-6').when_present.click
    $browser.button(:id, 'buy-now-button').click
  end
end



And(/^I wait for the payment page$/) do
  puts "##### Please make the payment process. YOU WOULD NEED TO SIGN IN #######"
end

And(/^I print the total expenditure for this trip to karan$/) do
  expenditure =
      {
          "roundtriptodelhi" => "#{$totaltripcost}",
          "cabfares" => "500 INR",
          "Bookexpenses" => $costofbook,
          "foodexpense" => "3000 INR"


      }
  expendituredetails = "********* PFB the expenditure details *********** \n Your round trip to delhi costs you #{expenditure['roundtriptodelhi']} \n The cabfares cost you #{expenditure['cabfares']} \n The book #{$nameofthebook} costs you #{expenditure['Bookexpenses']} \n The food expense costs you #{expenditure['foodexpense']}"
  puts expendituredetails
  File.open("expendituredetails.txt", "w") { |file| file.write(expendituredetails) }
end

Given(/^I go to cleartrip website$/) do
  $browser.goto load['Urls']['cleartrip']
end

Then(/^I go to amazon website$/) do
  $browser.goto load['Urls']['Amazon']
end