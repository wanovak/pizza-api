class Person < Sequel::Model
  one_to_many :pizzas
end
