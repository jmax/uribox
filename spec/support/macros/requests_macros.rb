module RequestMacros
  def sign_in_with_an_existing_user
    Goodies.create_a_user!.tap do |user|
      visit '/login'
      fill_in "user_email",    with: user.email
      fill_in "user_password", with: user.password
      click_button "Sign in"
    end
  end
end
