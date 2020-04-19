# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/pizza_accumulator.rb'

describe PizzaAccumulator do
  # Ideally this all goes in a YAML/JSON file
  let(:pizzas) do
    [{"id":25,"person_id":3,"type" => "pepperoni","consumed_at" => "2015-05-01 00:00:00 -0400"},{"id":2,"person_id":1,"type" => "sausage","consumed_at" => "2015-01-02 00:00:00 -0500"},{"id":3,"person_id":1,"type" => "pineapple","consumed_at" => "2015-01-03 00:00:00 -0500"},{"id":4,"person_id":1,"type" => "pepperoni","consumed_at" => "2015-01-06 00:00:00 -0500"},{"id":5,"person_id":1,"type" => "pepperoni","consumed_at" => "2015-01-06 00:00:00 -0500"},{"id":6,"person_id":1,"type" => "sausage","consumed_at" => "2015-01-07 00:00:00 -0500"},{"id":7,"person_id":1,"type" => "sausage","consumed_at" => "2015-01-07 00:00:00 -0500"},{"id":8,"person_id":1,"type" => "pineapple","consumed_at" => "2015-01-07 00:00:00 -0500"},{"id":9,"person_id":1,"type" => "pineapple","consumed_at" => "2015-01-08 00:00:00 -0500"},{"id":10,"person_id":1,"type" => "pepperoni","consumed_at" => "2015-01-09 00:00:00 -0500"},{"id":11,"person_id":1,"type" => "sausage","consumed_at" => "2015-01-10 00:00:00 -0500"},{"id":12,"person_id":1,"type" => "pineapple","consumed_at" => "2015-01-11 00:00:00 -0500"},{"id":13,"person_id":1,"type" => "pineapple","consumed_at" => "2015-01-12 00:00:00 -0500"},{"id":14,"person_id":1,"type" => "sausage","consumed_at" => "2015-01-13 00:00:00 -0500"},{"id":15,"person_id":1,"type" => "pepperoni","consumed_at" => "2015-01-15 00:00:00 -0500"},{"id":16,"person_id":1,"type" => "pineapple","consumed_at" => "2015-01-17 00:00:00 -0500"},{"id":17,"person_id":2,"type" => "sausage","consumed_at" => "2015-01-01 00:00:00 -0500"},{"id":18,"person_id":2,"type" => "sausage","consumed_at" => "2015-03-01 00:00:00 -0500"},{"id":19,"person_id":2,"type" => "pineapple","consumed_at" => "2015-03-01 00:00:00 -0500"},{"id":20,"person_id":2,"type" => "pepperoni","consumed_at" => "2015-08-01 00:00:00 -0400"},{"id":21,"person_id":3,"type" => "pepperoni","consumed_at" => "2015-02-01 00:00:00 -0500"},{"id":22,"person_id":3,"type" => "pepperoni","consumed_at" => "2015-04-01 00:00:00 -0400"},{"id":23,"person_id":3,"type" => "sausage","consumed_at" => "2015-05-01 00:00:00 -0400"},{"id":24,"person_id":3,"type" => "pineapple","consumed_at" => "2015-05-01 00:00:00 -0400"},{"id":1,"person_id":1,"type" => "pepperoni","consumed_at" => "2015-01-01 00:00:00 -0500"}]
  end
  let(:consumption_map_values) { [2, 1, 1, 2, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 3, 1] }
  let(:streak_values) { [ {start: "2015-01-03", end: "2015-01-07", streak: 3}, {start: "2015-02-01", end: "2015-03-01", streak: 2}, {start: "2015-04-01", end: "2015-05-01", streak: 2} ] }
  let(:month_status) { [ {month: 1, day: 7}, {month: 2, day: 1}, {month: 3, day: 1}, {month: 4, day: 1}, {month: 5, day: 1}, {month: 8, day: 1}] }

  let(:pizza_accumulator) { PizzaAccumulator.new(pizzas) }

  describe '#consolidate_days' do
    before do
      @result = pizza_accumulator.instance_variable_get(:@consumption_map)
    end

    it 'creates an array of hashes of the correct size' do
      expect(@result.size).to eq 18
    end

    it 'adds correctly' do
      expect(@result.values).to eq consumption_map_values
    end
  end

  # More robust tests on a real application, edge cases, bad data, etc.
  describe '#get_streaks' do
    before do
      @result = pizza_accumulator.streaks
    end

    it 'gets the correct streaks' do
      expect(@result).to eq streak_values
    end
  end

  # Likewise, more robust tests
  describe '#month_stats' do
    before do
      @result = pizza_accumulator.month_stats
    end

    it 'shows highest day of each month' do
      expect(@result).to eq month_status
    end
  end
end
