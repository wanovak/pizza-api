# frozen_string_literal: true

class Person < Sequel::Model
  one_to_many :pizzas
end
