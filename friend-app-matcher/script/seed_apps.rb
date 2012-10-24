# Seed app data
App.delete_all

APPS = %w(com.instapaper.android com.touchtype.swiftkey com.facebook.katana com.pandora.android
        com.instagram.android)

APPS.each do |app|
  App.create(app_id: app)
end

