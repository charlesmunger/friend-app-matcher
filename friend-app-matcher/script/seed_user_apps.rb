# Seed friend data
UserApp.delete_all
users = User.find(:all)
apps = App.find(:all)
users.each do |user|
  apps.each do |app|
    if (rand(3) % 3 == 0)
      UserApp.create(user_id: user.id, app_id: app.id)
    end
  end
end
