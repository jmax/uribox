class Goodies
  def self.create_a_user!
    User.create!(
      first_name: "Foo", last_name: "Bar", email: "bruce@wayne.com",
      password: "123456", password_confirmation: "123456"
    )
  end
end
