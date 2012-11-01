# Seed app data
App.delete_all

APPS = %w(com.instapaper.android 
          com.touchtype.swiftkey 
          com.facebook.katana 
          com.pandora.android
          com.instagram.android
          com.ltpublisher.dartsmaster
          com.chartcross.fieldcompass
          com.waze
          com.google.android.apps.maps
          com.google.earth
          com.yelp.android)

APPS.each do |app|
  App.create(app_id: app)
end

