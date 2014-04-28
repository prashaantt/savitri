desc 'First time setup'
task :setup do
  ##Development environment variables
  p 'Enter development database name'
  DEVELOPMENT_DATABASE_NAME = STDIN.gets.chomp#'savitri_development'
  p 'Enter development database username'
  DEVELOPMENT_POSTGRES_USERNAME = STDIN.gets.chomp#'postgres'
  p 'Enter development database password'
  DEVELOPMENT_POSTGRES_PASSWORD = STDIN.gets.chomp#'password'
  
  ##Staging environment variables
  p 'Enter staging database name'
  STAGING_DATABASE_NAME = STDIN.gets.chomp#'savitri_staging'
  p 'Enter staging database name'
  STAGING_POSTGRES_USERNAME = STDIN.gets.chomp#'postgres'
  p 'Enter staging database name'
  STAGING_POSTGRES_PASSWORD = STDIN.gets.chomp#'password'

  ## SMTP settings
  p 'Enter smtp address'
  SMTP_SETTINGS_ADDRESS = STDIN.gets.chomp#'email-smtp.us-east-1.amazonaws.com'
  p 'Enter smtp port'
  SMTP_SETTINGS_PORT = STDIN.gets.chomp#587
  p 'Enter smtp username'
  SMTP_SETTINGS_USER_NAME = STDIN.gets.chomp#'AKIAIJAGW2Y65MTYABAA'
  p 'Enter smtp password'
  SMTP_SETTINGS_PASSWORD = STDIN.gets.chomp#'Aoz2/HsoIrFVPmnj4d4qlnSri2x6mNcTAWkZngnKBQYL'

  begin
    file = File.open(Rails.root+'.env', "w")
    file.write("DEVELOPMENT_DATABASE_NAME = '#{DEVELOPMENT_DATABASE_NAME}'
DEVELOPMENT_POSTGRES_USERNAME = '#{DEVELOPMENT_POSTGRES_USERNAME}'
DEVELOPMENT_POSTGRES_PASSWORD = '#{DEVELOPMENT_POSTGRES_PASSWORD}'

STAGING_DATABASE_NAME = '#{STAGING_DATABASE_NAME}'
STAGING_POSTGRES_USERNAME = '#{STAGING_POSTGRES_USERNAME}'
STAGING_POSTGRES_PASSWORD = '#{STAGING_POSTGRES_PASSWORD}'

SMTP_SETTINGS_ADDRESS = '#{SMTP_SETTINGS_ADDRESS}'
SMTP_SETTINGS_PORT = #{SMTP_SETTINGS_PORT}
SMTP_SETTINGS_USER_NAME = '#{SMTP_SETTINGS_USER_NAME}'
SMTP_SETTINGS_PASSWORD = '#{SMTP_SETTINGS_PASSWORD}'")
  rescue IOError => e
    #some error occur, dir not writable etc.
  ensure
    file.close unless file == nil
  end
  system('rake dotenv')
  system('rake db:create')
  system('rake db:migrate')
  system('rake sunspot:solr:start')
  system('rake db:seed')
end

