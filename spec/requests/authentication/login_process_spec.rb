require 'spec_helper'

describe "Login Process" do
  before(:each) do
    Goodies.create_a_user!

    visit '/login'
  end

  context "with vaid data" do
    before(:each) do
      fill_in "user_email",    with: "bruce@wayne.com"
      fill_in "user_password", with: "123456"

      click_button "Sign in"
    end

    it "redirects logged in user to homepage" do
      current_path.should == root_path
    end

    it "flashes a welcome message" do
      page.should have_content("Signed in successfully.")
    end
  end

  context "with invalid data" do
    before(:each) do
      click_button "Sign in"
    end

    it "indicates fields were loaded unproperly" do
      page.should have_content("Invalid email or password.")
    end
  end
end
