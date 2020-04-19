# frozen_string_literal: true

require 'sequel'

raise 'Environment variable `PGSQL_USER` not found' if ENV['PGSQL_USER'].nil?
raise 'Environment variable `PGSQL_PW` not found' if ENV['PGSQL_PW'].nil?
raise 'Environment variable `PGSQL_DB` not found' if ENV['PGSQL_DB'].nil?

username = ENV['PGSQL_USER']
password = ENV['PGSQL_PW']
database = "#{ENV['PGSQL_DB']}_#{ENV['RACK_ENV'] || 'development'}"

# Assuming localhost and port 5432 for brevity since this will never be deployed
$db = Sequel.connect("postgres://#{username}:#{password}@localhost:5432/#{database}")
