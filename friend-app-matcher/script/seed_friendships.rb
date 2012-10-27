# Seed friend data
users = User.find(:all)
users.each do |user|
  users.each do |friend|
    if (user.id != friend.id)
      Friendship.create(user_id: user.id, friend_id: friend.id)
    end
  end
end
