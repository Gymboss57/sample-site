require 'json'

def consoleHeading(taskName)

  puts
  puts '---------------------------------------'
  puts taskName + '...'
  puts '---------------------------------------'

end

task :default do

  consoleHeading('Installing Ruby Gems')
  sh    'bundle install --path=vendor'

end

task :clean do

  consoleHeading('Cleaning up')
  sh    'rm -rf ./.bundle'
  sh    'rm -rf ./.cache'
  sh    'rm -rf ./.sass-cache'
  sh    'rm -rf ./build'
  sh    'rm -rf ./vendor'

end
