require "rspec"
require "capybara"

feature "Messages" do
  scenario "As a user, I can submit a message" do
    visit "/"
    expect(page).to have_content("Message Roullete")

    fill_in "Message", :with => "Hello Everyone!"

    click_button "Submit"

    expect(page).to have_content("Hello Everyone!")
  end

  scenario "As a user, I see an error message if I enter a message > 140 characters" do
    visit "/"

    fill_in "Message", :with => "a" * 141

    click_button "Submit"

    expect(page).to have_content("Message must be less than 140 characters.")
  end

  scenario "As a user, I see a prefilled form when clicking Edit for a msg"do
    visit "/"

    fill_in "Message", :with => "a" * 3

    click_button "Submit"

    click_link "Edit"

    find_field("msg").value

    fill_in "msg", :with => "Hello"
    click_button "Edit Message"
    expect(page).to have_content("Hello")
    expect(page).to have_content("Message Roullete")
  end
end
