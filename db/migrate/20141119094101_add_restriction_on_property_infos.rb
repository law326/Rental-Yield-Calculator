class AddRestrictionOnPropertyInfos < ActiveRecord::Migration
  def change
    change_column :property_infos, :email, :string, null: false
    change_column :property_infos, :phone_number, :string, null: false
    change_column :property_infos, :postcode, :string, null: false
    change_column :property_infos, :rental_period_type_id, :integer, null: false
    change_column :property_infos, :rent_income, :integer, null: false
    change_column :property_infos, :property_cost, :integer, null: false
  end
end
