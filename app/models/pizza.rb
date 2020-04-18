# frozen_string_literal: true

class Pizza < Sequel::Model
  many_to_one :person
end
