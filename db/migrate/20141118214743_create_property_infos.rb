class CreatePropertyInfos < ActiveRecord::Migration
  def change
    create_table :property_infos do |t|
      t.string :email
      t.string :phone_number
      t.string :postcode
      t.integer :rental_period_type_id
      t.integer :rent_income
      t.integer :property_cost

      t.timestamps
    end
  end
end
