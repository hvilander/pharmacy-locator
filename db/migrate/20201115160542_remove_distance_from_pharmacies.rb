class RemoveDistanceFromPharmacies < ActiveRecord::Migration[6.0]
  def change
    remove_column :pharmacies, :distance, :decimal
  end
end
