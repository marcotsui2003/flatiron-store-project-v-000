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

  def checkout
    self.items.each do  |item|
      line_item = LineItem.find_by(item_id: item.id)
      item.inventory -= line_item.quantity
      item.save
    end
    self.update(status: "submitted")
    self.current_user.update(current_cart: nil)
  end

end
