# Seed medium size database

NUM_USERS = 10000
NUM_FRIENDS_MEAN = 250
NUM_FRIENDS_SD = 100
NUM_APPS = 10000
APP_POPULARITY = {
    1 => 0.3,
    6 => 0.1,
    26 => 0.01,
    56 => 0.001,
    100 => 0.005
}

def gen_random_numbers(num_random, range)
  random_numbers = Set.new
  while random_numbers.size < num_random
    random_numbers.add(Random.rand(range))
  end
  random_numbers
end

def get_app_popularity(id)
  id_shard = id % 100
  APP_POPULARITY.keys.each do |key|
    if id_shard <= key
      return APP_POPULARITY[key]
    end
  end
end

User.delete_all
users = []
User.transaction do
  (1..NUM_USERS).each do |i|
    users << User.create(email: "testuser#{i}@test.com",
                password: "password",
                password_confirmation: "password",
                uid: "#{i}0#{i}0#{i}0#{i}0#{i}0",
                remember_me: false,
                provider: "facebook",
                username: "testuser#{i}",
                name: "testuser#{i}")
  end
end

friend_dist = Rubystats::NormalDistribution.new(NUM_FRIENDS_MEAN, NUM_FRIENDS_SD)
Friendship.delete_all
users = User.all
Friendship.transaction do
  users.each do |user|
    random_friends = gen_random_numbers(friend_dist.rng, NUM_USERS)
    random_friends.each do |friend_index|
      if (user.id != users[friend_index].id)
        Friendship.create(user_id: user.id, friend_id: users[friend_index].id)
      end
    end
  end
end

App.delete_all
apps = []
App.transaction do
  (1..NUM_APPS).each do |i|
    apps << App.create(app_id: "android.app.#{i}")
  end
end

UserApp.delete_all
UserApp.transaction do
  apps.each do |app|
    popularity = get_app_popularity app.id
    num_installations = popularity * NUM_USERS
    random_users = gen_random_numbers num_installations, NUM_USERS
    random_users.each do |random_user|
      UserApp.create(user_id: users[random_user].id, app_id: app.id, installed: true)
    end
  end
end

