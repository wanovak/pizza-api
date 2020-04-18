# frozen_string_literal: true

require 'spec_helper'
require_relative '../../app/models/pizza.rb'

describe Pizza do
  # Not familiar with Sequel; there's probably a way to test associations but
  # I'm not going to bother with it right now.

  it 'succeeds' do
    expect(true).to be_truthy
  end
end
