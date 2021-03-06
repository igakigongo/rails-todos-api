# frozen_string_literal: true

class Item < ApplicationRecord
  # model association
  belongs_to :todo

  # validations
  validates_presence_of :name
end
