require 'highline/import'
desc "Creates a savitri administrator"
task "admin:create" => :environment do
  name = ask("Name:  ")
  username = ask("Username:  ")
  email = ask("Email:  ")
  password = ask("Password: ")
  password_confirmation = ask("Confirm password: ")
  u = User.new(name: name, username: username, email: email, password: password,
  	           password_confirmation: password_confirmation, role_id: 1, 
  	           confirmed_at: Time.zone.now)
  u.save
end
