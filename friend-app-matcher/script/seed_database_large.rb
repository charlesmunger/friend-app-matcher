# Seed medium size database

NUM_USERS = 10000
NUM_FRIENDS_MEAN = 20
NUM_FRIENDS_SD = 5
NUM_APPS = 10000
APP_POPULARITY = {
    1 => 0.1,
    6 => 0.01,
    26 => 0.001,
    56 => 0.0005,
    100 => 0.0001
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
i = 0
while i < NUM_USERS/100
  User.transaction do
    (0..99).each do |j|
      users << User.create(email: "testuser#{j + (100*i)}@test.com",
                password: "password",
                password_confirmation: "password",
                uid: "#{j + (100*i)}0#{j + (100*i)}0#{j + (100*i)}0#{j + (100*i)}0#{j + (100*i)}0",
                remember_me: false,
                provider: "facebook",
                username: "testuser#{j + (100*i)}",
                name: "testuser#{j + (100*i)}").id
    end
    i += 1
  end
end

friend_dist = Rubystats::NormalDistribution.new(NUM_FRIENDS_MEAN, NUM_FRIENDS_SD)
Friendship.delete_all
i = 0
while i < NUM_USERS/100
  Friendship.transaction do
    (0..99).each do |j|
      random_friends = gen_random_numbers(friend_dist.rng, NUM_USERS)
      random_friends.each do |friend_index|
        if (users[(i * 100) + j] != users[friend_index])
          Friendship.create(user_id: users[(i * 100) + j], friend_id: users[friend_index])
        end
      end
    end
    i += 1
  end
end

App.delete_all
apps = []
i = 0
while i < NUM_APPS/100
  App.transaction do
    (0..99).each do |j|
      apps << App.create(app_id: "android.app.#{(i * 100) + j}").id
    end
    i += 1
  end
end

UserApp.delete_all
i = 0
while i < NUM_APPS/100
  UserApp.transaction do
    (0..99).each do |j|
      popularity = get_app_popularity (100 * i) + j
      num_installations = popularity * NUM_USERS
      random_users = gen_random_numbers num_installations, NUM_USERS
      random_users.each do |random_user|
        UserApp.create(user_id: users[random_user], app_id: apps[(100 * i) + j], installed: true)
      end
    end
    i += 1
  end
end

