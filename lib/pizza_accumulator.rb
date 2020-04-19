# frozen_string_literal: true

require 'active_support/core_ext/hash'

class PizzaAccumulator
  def initialize(dataset)
    @dataset = dataset.sort_by { |k| k['consumed_at'] }
    @consumption_map = {}
    @streaks = []
    @month_stats = []

    consolidate_days
  end

  def consolidate_days
    @dataset.each do |dataset|
      day = dataset.with_indifferent_access['consumed_at'].to_s[0..9]
      if @consumption_map.keys.include?(day)
        @consumption_map[day] += 1
      else
        @consumption_map[day] = 1
      end
    end
  end

  # Requirements unclear- assumption to not count streaks of size 1
  def streaks
    streak_start = nil
    streak = 1
    prev_day = nil
    prev_eaten = 0

    @consumption_map.each_with_index do |(curr_day, curr_eaten), idx|
      if curr_eaten > prev_eaten && !idx.zero?
        streak += 1
      else
        @streaks << { start: streak_start, end: prev_day, streak: streak } if streak > 1
        streak = 1
        streak_start = nil
      end

      prev_day = curr_day
      prev_eaten = curr_eaten
      streak_start = prev_day if streak_start.nil?
    end

    @streaks
  end

  def month_stats
    month_accum = {}
    @consumption_map.each do |day, eaten|
      date = day.to_date
      month_accum[date.month] = {} unless month_accum.include? date.month

      unless (month_accum[date.month][:eaten] || 0) > eaten
        month_accum[date.month] = { day: date.day, eaten: eaten }
      end
    end

    month_accum.each do |key, value|
      @month_stats << { month: key, day: value[:day] }
    end

    @month_stats
  end
end
