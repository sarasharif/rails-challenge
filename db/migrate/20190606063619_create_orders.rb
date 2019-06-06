class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer     :cost
      t.integer     :status, default: 0
      t.belongs_to  :customer, index: true
      t.timestamps
    end
 
    create_table :suborders do |t|
      t.integer     :count
      t.references  :variant, index: true
      t.belongs_to  :order, index: true
    end
  end
end
