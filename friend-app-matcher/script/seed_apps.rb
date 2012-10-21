# Seed app data
App.delete_all
App.transaction do
  (1..100).each do |i|
    App.create(app_id: "app_id_#{i}", name: "App #{i}")
  end
end
