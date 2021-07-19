class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.belongs_to :product
      t.belongs_to :user
      t.integer :quantity
      t.timestamps
    end
  end
end
