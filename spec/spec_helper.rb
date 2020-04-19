# frozen_string_literal: true

require 'sequel'
require_relative '../app/initializers/database.rb'

RSpec.configure do |c|
  c.around(:each) do |example|
    $db.transaction(rollback: :always, auto_savepoint: true) { example.run }
  end
end
