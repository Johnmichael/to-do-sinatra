require('capybara/rspec')
require('./app')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('Create, Update, and Delete', {:type => :feature}) do
  it('Processes user input and creates tasks name and details') do
    visit('/')
    fill_in('name', :with => 'Study Databases')
    fill_in('detail', :with => 'Go over homework and stuff')
    click_button('Add Objective')
    expect(page).to have_content('Study Databases')
  end

  it('Updates the detail') do
    visit('/1')
    click_button('Edit')
    fill_in('detail', :with => 'Chapters 5-6')
    click_button('Confirm')
    visit('/1')
    expect(page).to have_content('Chapters 5-6')
  end

  it('Deletes the user input and returns home') do
    visit('/1')
    click_button('Delete')
    expect(page).to have_no_content('Study Databases')
  end
end
