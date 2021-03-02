# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Todo, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { is_expected.to have_many(:items).dependent(:destroy) }

  # Validation tests
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:created_by) }
end
