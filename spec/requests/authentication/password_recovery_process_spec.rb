require 'spec_helper'

describe "Password Recovery Process" do
  before(:each) do
    @user = Goodies.create_a_user!

    visit '/reset-password'
  end

  context "with valid data" do
    before(:each) do
      fill_in "user_email",    with: @user.email
      click_button "Send me reset password instructions"
    end

    it "redirects to login page" do
      current_path.should == new_user_session_path
    end

    it "flashes confirmation message" do
      page.should have_content(
        "You will receive an email with instructions about how to reset" + 
        " your password in a few minutes."
      )
    end

    context "Email Notification" do
      before(:each) do
        @notification = ActionMailer::Base.deliveries.last
      end

      it "sends a notification to user" do
        @notification.to.should include(@user.email)
      end

      it "sends a notification with proper subject" do
        @notification.subject.should == "Reset password instructions"
      end
    end
  end
end
