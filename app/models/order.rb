class Order < ApplicationRecord
  belongs_to :customer
  has_many :suborders
  enum status: { pending: 0, processing: 1, fulfilled: 2, delivered: 3, canceled: 4 }
end

class Suborder < ApplicationRecord
  belongs_to :order
  belongs_to :variant
  has_one :product, :through => :variant
end
