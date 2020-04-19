# frozen_string_literal: true

require 'grape'

module PizzaApi
  class People < Grape::API
    format :json

    resource :people do
      desc 'Returns all people'
      get :all do
        people = $db.from(:people)
        people.all
      end

      desc 'Returns person by name'
      get :by_name do
        # Assuming Sequel gem has some sane sanitization going on under the hood
        people = $db.from(:people).where(name: params[:name])
        people.all
      end
    end
  end
end
