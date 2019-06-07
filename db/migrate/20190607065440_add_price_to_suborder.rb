class AddPriceToSuborder < ActiveRecord::Migration[5.2]
  def change
    add_column :suborders, :price, :integer
  end
end
