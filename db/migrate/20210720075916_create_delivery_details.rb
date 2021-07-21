class CreateDeliveryDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :delivery_details do |t|
      t.belongs_to :user
      t.string :address
      t.string :phone_no
      t.timestamps
    end
  end
end
