class Order < ApplicationRecord
  has_many :suborders
  enum status: { pending: 0, processing: 1, fulfilled: 2, delivered: 3, canceled: 4 }
end