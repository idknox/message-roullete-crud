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
    save_and_open_page
    fill_in "Message", :with => "a" * 141

    click_button "Submit"

    expect(page).to have_content("Message must be less than 140 characters.")
  end

  scenario "As a user, I see a prefilled form when clicking Edit for a msg" do
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

  scenario "user sees error if incorrect editing" do
    visit "/"

    fill_in "Message", :with => "a" * 3

    click_button "Submit"

    click_link "Edit"

    find_field("msg").value

    fill_in "msg", :with => "a" * 141
    click_button "Edit Message"
    expect(page).to have_content("Message must be less than 140 characters.")
  end

  scenario "user can delete message" do
    visit "/"

    fill_in "Message", :with => "a" * 3

    click_button "Submit"

    click_button "Delete"

    expect(page).to_not have_content("a" * 3)
    expect(page).to have_content("Message Roullete")
  end

  scenario "user can comment on msg" do

    visit "/"

    fill_in "Message", :with => "a" * 3

    click_button "Submit"

    click_link("Comment")
    fill_in("comment", :with => "Good idea!")
    click_button("Add Comment")

    expect(page).to have_content("Message Roullete")
    expect(page).to have_content("Good idea!")
    expect(page).to have_content("aaa")
  end

  scenario "user can view msg page with comments" do
    visit "/"

    fill_in "Message", :with => "a" * 3

    click_button "Submit"

    click_link("Comment")
    fill_in("comment", :with => "Good idea!")
    click_button("Add Comment")

    fill_in "Message", :with => "b" * 3
    click_button "Submit"

    click_link("aaa")
    expect(page).to have_content("aaa")
    expect(page).to have_content("Good idea!")
    expect(page).to_not have_content("bbb")
  end
end
