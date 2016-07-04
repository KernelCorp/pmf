# Load DSL and set up stages
require 'capistrano/setup'
# Include default deployment tasks
require 'capistrano/deploy'
# require 'whenever/capistrano'
require 'capistrano/puma'
require 'capistrano/puma/workers'

require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
