# frozen_string_literal: true

require 'csv'
require 'rspec/core/rake_task'
require 'sequel'
require_relative 'app/initializers/application.rb'

namespace :api do
  task :routes do
    PizzaApi::API.routes.each do |route|
      method = route.request_method.ljust(10)
      path = route.origin
      puts "     #{method} #{path}"
    end
  end
end

# XXX: If another namespace is added, relocate to lib/tasks
namespace :db do
  desc 'Create tables on specified database'
  task :create do
    raise 'Problem connecting to database with provided credentials. Are credentials OK?' unless $db

    $db.create_table :people do
      primary_key :id
      String :name
    end

    $db.create_table :pizzas do
      primary_key :id
      Integer :person_id
      String :type
      DateTime :consumed_at
    end

    puts 'Tables created successfully!'
  end

  desc 'Loads data into database'
  task :seed do
    filename = 'data/data.csv'

    require_relative 'app/models/person.rb'
    require_relative 'app/models/pizza.rb'

    # Based on the initial data set, we can do some optimizations in memory as
    # opposed to querying the database.
    names = []

    CSV.foreach(filename, headers: true) do |row|
      data = row.to_hash
      unless names.include? data['person']
        create_person(data['person'])
        names << data['person']
      end
      create_pizza(data)
    end

    puts 'Tables seeded successfully!'
  end

  def create_person(name)
    # We'll require a name here
    return if name.to_s.strip.empty?

    person = Person.new(name: name)
    person.save
  end

  def create_pizza(data)
    # We'll require type and consumed_at
    return if data['meat-type'].to_s.strip.empty? || data['date'].to_s.strip.empty?

    # This could certainly be optimized in memory, but this'll do for now
    person = Person.where(name: data['person']).first

    pizza = Pizza.new(type: data['meat-type'], consumed_at: data['date'], person: person)
    pizza.save
  end
end
