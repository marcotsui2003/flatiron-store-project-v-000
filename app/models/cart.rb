class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items
  has_one :current_user, class_name: "User", foreign_key: "current_cart_id"

  def total
    self.items.pluck(:price).reduce(:+)
  end

  def add_item(id)
    if line_item = self.line_items.find_by(item_id: id)
      line_item.quantity += 1
      line_item
    else
      line_item = self.line_items.build(item_id: id)
    end
  end

end
