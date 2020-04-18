# frozen_string_literal: true

require 'sequel'

# There's probably a better place to put this since it's duplicated between
# here, the Rakefile, and soon-to-be somewhere in the boot-up proc sequence.
raise 'Environment variable `PGSQL_USER` not found' if ENV['PGSQL_USER'].nil?
raise 'Environment variable `PGSQL_PW` not found' if ENV['PGSQL_PW'].nil?
raise 'Environment variable `PGSQL_DB` not found' if ENV['PGSQL_DB'].nil?

username = ENV['PGSQL_USER']
password = ENV['PGSQL_PW']
database = "#{ENV['PGSQL_DB']}_#{ENV['RACK_ENV'] || 'dev'}"

# Assuming localhost and port 5432 for brevity since this will never be deployed
db = Sequel.connect("postgres://#{username}:#{password}@localhost:5432/#{database}")

RSpec.configure do |c|
  c.around(:each) do |example|
    db.transaction(rollback: :always, auto_savepoint: true) { example.run }
  end
end
