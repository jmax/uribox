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

describe "Sign up Process" do
  context "with valid data" do
    before(:each) do
      visit '/join'
      fill_in      "user_first_name",            with: "Bruce"
      fill_in      "user_last_name",             with: "Wayne"
      fill_in      "user_email",                 with: "bruce@wayne.com"
      fill_in      "user_password",              with: "123456"
      fill_in      "user_password_confirmation", with: "123456"
      click_button "Sign up"
    end

    it  "creates a new user account with provided data" do
      User.count.should == 1
    end

    it "redirects user to homepage" do
      current_path.should == root_path
    end

    it "flashes a welcome message" do
      page.should have_content("Welcome! You have signed up successfully.")
    end
  end

  context "with invalid data" do
    before(:each) do
      visit '/join'
    end

    context "No first name provided" do
      before(:each) do
        fill_in      "user_last_name",             with: "Wayne"
        fill_in      "user_email",                 with: "bruce@wayne.com"
        fill_in      "user_password",              with: "123456"
        fill_in      "user_password_confirmation", with: "123456"
        click_button "Sign up"
      end

      it "requires first name as a mandatory field" do
        page.should have_content("Please review the problems below:")
        page.should have_content("can't be blank")
      end
    end

    context "No last name provided" do
      before(:each) do
        fill_in      "user_first_name",            with: "Bruce"
        fill_in      "user_email",                 with: "bruce@wayne.com"
        fill_in      "user_password",              with: "123456"
        fill_in      "user_password_confirmation", with: "123456"
        click_button "Sign up"
      end

      it "requires last name as a mandatory field" do
        page.should have_content("Please review the problems below:")
        page.should have_content("can't be blank")
      end
    end

    context "No email provided" do
      before(:each) do
        fill_in      "user_first_name",            with: "Bruce"
        fill_in      "user_last_name",             with: "Wayne"
        fill_in      "user_password",              with: "123456"
        fill_in      "user_password_confirmation", with: "123456"
        click_button "Sign up"
      end

      it "requires email as a mandatory field" do
        page.should have_content("Please review the problems below:")
        page.should have_content("can't be blank")
      end
    end

    context "No password provided" do
      before(:each) do
        fill_in      "user_first_name",            with: "Bruce"
        fill_in      "user_last_name",             with: "Wayne"
        fill_in      "user_email",                 with: "bruce@wayne.com"
        fill_in      "user_password_confirmation", with: "123456"
        click_button "Sign up"
      end

      it "requires email as a mandatory field" do
        page.should have_content("Please review the problems below:")
        page.should have_content("can't be blank")
      end
    end

    context "No password confirmation provided" do
      before(:each) do
        fill_in      "user_first_name",            with: "Bruce"
        fill_in      "user_last_name",             with: "Wayne"
        fill_in      "user_email",                 with: "bruce@wayne.com"
        fill_in      "user_password",              with: "123456"
        click_button "Sign up"
      end

      it "requires email as a mandatory field" do
        page.should have_content("Please review the problems below:")
        page.should have_content("doesn't match confirmation")
      end
    end

    context "Providing an exisiting email" do
      before(:each) do
        Goodies.create_a_user!

        fill_in      "user_first_name",            with: "Bruce"
        fill_in      "user_last_name",             with: "Wayne"
        fill_in      "user_email",                 with: "bruce@wayne.com"
        fill_in      "user_password",              with: "123456"
        fill_in      "user_password_confirmation", with: "123456"
        click_button "Sign up"
      end

      it "requires email as a unique field" do
        page.should have_content("Please review the problems below:")
        page.should have_content("has already been taken")
      end
    end
  end

  describe "With a logged in User" do
    before(:each) do
      Goodies.create_a_user!.tap do |user|
        visit '/login'
        fill_in "user_email",    with: user.email
        fill_in "user_password", with: user.password
        click_button "Sign in"
      end
    end

    context "visiting join page" do
      before(:each) do
        visit '/join'
      end

      it "redirects user to homepage" do
        current_path.should == root_path
      end

      it "flashes explanatory message" do
        page.should have_content("You are already signed in.")
      end
    end

    context "visiting login page" do
      before(:each) do
        visit '/login'
      end

      it "redirects user to homepage" do
        current_path.should == root_path
      end

      it "flashes explanatory message" do
        page.should have_content("You are already signed in.")
      end
    end
  end
end
