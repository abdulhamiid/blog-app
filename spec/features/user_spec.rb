require "rails_helper"

RSpec.describe "users/index.html.erb", type: :feature do
  before :each do
    User.create(name: 'John Doe', bio: 'Lorem ipsum dolor sit', posts_counter: 0)
    User.create(name: 'Mary Williams', bio: 'Lorem ipsum dolor', posts_counter: 0)
  end
  it "displays page header" do
    visit users_path
    expect(page).to have_text('All Users')
  end

  it "displays all users" do
    visit users_path
    expect(page).to have_content 'John Doe'
    expect(page).to have_content 'Mary Williams'
  end

  it "displays number of posts for each user" do
    visit users_path
    expect(page).to have_content 'Number of posts: 0'
  end

  it "it redirect to user show page" do
    visit users_path
    expect(page).to have_link 'John Doe', href: user_path(User.first)
    click_link 'John Doe'
    expect(page).to have_current_path(user_path(User.first))
  end

  it "displays correct user name by clicking on user" do
    visit users_path
    click_on 'Mary Williams'
    expect(page).to have_content 'Mary Williams'
    expect(page).to have_content 'Lorem ipsum dolor'
  end

end
