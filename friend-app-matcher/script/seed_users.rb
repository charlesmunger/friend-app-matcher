# Seed user data
User.delete_all
User.transaction do
  (1..12).each do |i|
    User.create(email: "testuser#{i}@test.com",
                password: "password",
                password_confirmation: "password",
                uid: "#{i}0#{i}0#{i}0#{i}0#{i}0",
                remember_me: false,
                provider: "facebook",
                username: "testuser#{i}",
                name: "testuser#{i}")
  end
end
