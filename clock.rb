require 'clockwork'
module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  # handler receives the time when job is prepared to run in the 2nd argument
  # handler do |job, time|
  #   puts "Running #{job}, at #{time}"
  # end

  # every(10.seconds, 'frequent.job')
  every(1.day, `bundle exec rake sitemap:refresh`, :at => '00:00')
  # every(1.hour, 'hourly.job')

  # every(1.day, 'midnight.job', :at => '00:00')
end
