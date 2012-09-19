require 'spec_helper'

describe "Home Page" do
  context "without a logged in user" do
    before(:each) do
      visit "/"
    end

    it "displays a headline title" do
      find(".hero-unit").find("h1").should have_content("Welcome to UriBox!")
    end

    it "displays a tagline message" do
      find(".hero-unit").should have_content(
        "Sharing knowledge between coworkers couldn't be easier now.")
    end

    it "displays join button" do
      find(".hero-unit").find("a.btn-large").should have_content(
        "Join now. It's totally free!"
      )
    end

    it "links to signup page" do
      find(".hero-unit").click_link("join-now")
      current_path.should == join_path
    end

    context "Main Navigation" do
      it "displays a link to signup page" do
        find(".navbar").find("ul.nav").find(".join-for-free").should have_content("Join for Free")
      end

      it "displays a link to login page" do
        find(".navbar").find("ul.nav").find(".login").should have_content("Login")
      end
    end
  end

  context "with a logged in user" do
    before(:each) do
      sign_in_with_an_existing_user
    end

    context "Main Navigation" do
      it "displays a link to logout" do
        find(".navbar").find("ul.nav").find(".login").should have_content("Logout")
      end
    end
  end
end
