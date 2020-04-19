require 'grape'
require_relative '../../api/people.rb'
require_relative '../../api/pizza.rb'

module PizzaApi
  class API < Grape::API
    prefix 'api'
    format :json

    mount ::PizzaApi::People
    mount ::PizzaApi::Pizza
  end
end
