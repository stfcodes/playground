require 'bundler/setup'
Bundler.require(:default)

require 'logger'

root        = File.expand_path('..', __dir__)
config_file = File.join(root, 'db/config.yml')
ActiveRecord::Base.configurations = YAML.load_file(config_file)
ActiveRecord::Base.establish_connection(:development)
ActiveRecord::Base.logger = Logger.new(STDOUT)

directories = %w(models services)
directories.each do |dir|
  Dir[File.join(root, dir, '*.rb')].each { |f| require(f) }
end
