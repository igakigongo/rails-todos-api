# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  # association test
  # ensure that items belongs to a single todo
  it { is_expected.to belong_to(:todo) }

  # validation tests
  # ensure name is present before saving the item
  it { is_expected.to validate_presence_of(:name) }
end
