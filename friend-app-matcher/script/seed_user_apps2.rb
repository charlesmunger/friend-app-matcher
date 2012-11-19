# Seed friend data
UserApp.delete_all
users = User.find(:all)
apps = App.find(:all)
users.each do |user|
  apps.each do |app|
    UserApp.create(user_id: user.id, app_id: app.id, installed: true)
  end
end
