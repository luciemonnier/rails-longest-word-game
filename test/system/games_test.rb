require 'application_system_test_case'

class GamesTest < ApplicationSystemTestCase
  test 'Going to /new gives us a new random grid to play with' do
    visit new_url
    assert test: 'New game'
    assert_selector 'li', count: 10
  end

  test 'Should tell when the message is not in the grid' do
    visit new_url
    fill_in 'word', with: 'afrhgsjkdmf'
    click_on 'button'
    assert test: 'CHEATER, Afrhgsjkdmf IS NOT IN THE GRID'
  end

  test 'Should tell that the message is not an English word' do
    visit new_url
    fill_in 'word', with: 'f'
    click_on 'button'
    assert test: "Sorry, F isn't an english word..."
  end
end
