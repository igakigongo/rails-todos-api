require 'rails_helper'

RSpec.describe Item, type: :model do
  # association test
  # ensure that items belongs to a single todo
  it { should belong_to(:todo) }

  # validation tests
  # ensure name is present before saving the item
  it { should validate_presence_of(:name) }
end
