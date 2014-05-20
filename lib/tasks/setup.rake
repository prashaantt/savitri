desc 'Not First time setup'

task :fsetup do
  raise 'do not run in production' if Rails.env.production?
  
  puts "*** #{Rails.env} *** mode"

  ["set_env_specific_variables", "set_env_variables",
   "db:drop", "db:create", "db:migrate", 
   "sunspot:solr:start RAILS_ENV=#{Rails.env}", "db:seed"].each { |cmd| system "rake #{cmd}" }

  puts 'Done'
end

desc "Set Environment Variables"
task :set_env_specific_variables do
  p 'Enter database type'
  DATABASE_TYPE = STDIN.gets.chomp #'postgresql#sqlite3'
  p 'Enter database name'
  DATABASE_NAME = STDIN.gets.chomp #'savitri'
  p 'Enter database username'
  DATABASE_USERNAME = STDIN.gets.chomp #'postgres'
  p 'Enter database password'
  DATABASE_PASSWORD = STDIN.gets.chomp #'password'

    begin
    file = File.open(Rails.root + ".env.#{Rails.env}", "w")
    file.write("DATABASE_TYPE = '#{DATABASE_TYPE}'
DATABASE_NAME = '#{DATABASE_NAME}'
DATABASE_USERNAME = '#{DATABASE_USERNAME}'
DATABASE_PASSWORD = '#{DATABASE_PASSWORD}'")
  rescue IOError => e
    #some error occur, dir not writable etc.
  ensure
    file.close unless file == nil
  end
end

desc "Set Environment Variables"
task :set_env_variables do
  p 'Do you want to setup SMTP settings ?'
  CONTINUE_OR_NOT = STDIN.gets.chomp
  if 'Y'.casecmp(CONTINUE_OR_NOT) == 0
      p 'Enter smtp address'
      SMTP_SETTINGS_ADDRESS = STDIN.gets.chomp #'email-smtp.us-east-1.amazonaws.com'
      p 'Enter smtp port'
      SMTP_SETTINGS_PORT = STDIN.gets.chomp #587
      p 'Enter smtp username'
      SMTP_SETTINGS_USER_NAME = STDIN.gets.chomp #'AKIAIJAGW2Y65MTYABAA'
      p 'Enter smtp password'
      SMTP_SETTINGS_PASSWORD = STDIN.gets.chomp #'Aoz2/HsoIrFVPmnj4d4qlnSri2x6mNcTAWkZngnKBQYL'

        begin
        file = File.open(Rails.root + ".env", "w")
        file.write("SMTP_SETTINGS_ADDRESS = '#{SMTP_SETTINGS_ADDRESS}'
    SMTP_SETTINGS_PORT = '#{SMTP_SETTINGS_PORT}'
    SMTP_SETTINGS_USER_NAME = '#{SMTP_SETTINGS_USER_NAME}'
    SMTP_SETTINGS_PASSWORD = '#{SMTP_SETTINGS_PASSWORD}'")
      rescue IOError => e
        #some error occur, dir not writable etc.
      ensure
        file.close unless file == nil
      end
  end
end
