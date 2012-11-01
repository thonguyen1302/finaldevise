namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [User].each(&:delete_all)
    
    User.populate 50 do |user|
      user.email = Faker::Internet.email
      user.encrypted_password = Populator.words(1..5).titleize
      user.first_name = Populator.words(1..5).titleize
      user.last_name = Populator.words(1..5).titleize
      user.birthday = 2.years.ago..Time.now
      user.phone_number = Faker::PhoneNumber.phone_number
      user.reset_password_token = Populator.words(1..20).titleize
      user.reset_password_sent_at = 2.years.ago..Time.now
      user.remember_created_at = 2.years.ago..Time.now
      user.sign_in_count = [4, 19, 100]
      user.current_sign_in_at = 2.years.ago..Time.now
      user.last_sign_in_at = 2.years.ago..Time.now
      user.current_sign_in_ip = Populator.words(1..5).titleize
      user.last_sign_in_ip = Populator.words(1..5).titleize
      user.confirmation_token = Populator.words(1..5).titleize
      user.confirmed_at = 2.years.ago..Time.now
      user.confirmation_sent_at = 2.years.ago..Time.now
      user.unconfirmed_email = Faker::Internet.email
      user.created_at = 2.years.ago..Time.now
      user.updated_at = 2.years.ago..Time.now
      user.provider = Populator.words(1..5).titleize
      user.uid = Populator.words(1..5).titleize
      user.name = Populator.words(1..5).titleize
      user.oauth_token = Populator.words(1..5).titleize
      user.oauth_expires_at = 2.years.ago..Time.now
      user.status = Populator.words(1..5).titleize
    end


   
  
   
   


    
  end
end