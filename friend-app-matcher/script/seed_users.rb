# Seed user data
User.transaction do
  (1..12).each do |i|
    User.create(auth_token: "token_#{i}", user_id: "testuser#{i}@test.com")
  end
end
