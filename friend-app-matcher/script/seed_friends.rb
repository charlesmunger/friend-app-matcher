# Seed friend data
users = User.find(:all)
users.each do |user|
  users.each do |friend|
    if (user.user_id != friend.user_id)
      Friend.create(user_id: user.user_id, friend_id: friend.user_id)
    end
  end
end
