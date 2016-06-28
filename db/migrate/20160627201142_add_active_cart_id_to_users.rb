class AddActiveCartIdToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :current_cart, index: true
  end
end
