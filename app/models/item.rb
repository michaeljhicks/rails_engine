class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

end


# class Item < ApplicationRecord
#   belongs_to :merchant
#   has_many :invoice_items, dependent: :destroy
#   has_many :invoices, through: :invoice_items
#   has_many :transactions, through: :invoices
#
#   validates :name, presence: true, length: { allow_blank: false }
#   validates :description, presence: true, length: { allow_blank: false }
#   validates :unit_price, presence: true, numericality: { only_integer: false, greater_than: 0 }
#
#   def self.single_item(name)
#     Item.find_by("name ilike ?", "%#{name}%")
#   end
#
#   def self.multiple_items(name)
#     Item.where("name ilike ?", "%#{name}%")
#   end
# end
