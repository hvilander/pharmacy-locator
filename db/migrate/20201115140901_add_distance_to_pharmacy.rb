class AddDistanceToPharmacy < ActiveRecord::Migration[6.0]
  def change
    add_column :pharmacies, :distance, :decimal
  end
end
