# frozen_string_literal: true

require 'grape'
require_relative '../lib/pizza_accumulator.rb'

module PizzaApi
  class Pizza < Grape::API
    format :json

    helpers do
      def all_consumptions
        consumptions = $db.from(:pizzas)
        consumptions.all
      end
    end

    resource :pizza do
      desc 'Returns all consumptions'
      get :consumptions do
        all_consumptions
      end

      # A streak is defined as a succession of days where pizza consumption increases, skipping days
      # where no pizza was eaten
      desc 'Returns streak stats'
      get :streak do
        accum = PizzaAccumulator.new(all_consumptions)
        accum.streaks
      end

      desc 'Returns month stats'
      get :month do
        accum = PizzaAccumulator.new(all_consumptions)
        accum.month_stats
      end

      desc 'Returns consumption by meat type'
      get :by_type do
        # Assuming Sequel gem has some sane sanitization going on under the hood
        pizza = $db.from(:pizzas).where(type: params[:type])
        pizza.all
      end
    end
  end
end
