class CreateRestrictedBrands < ActiveRecord::Migration[8.0]
  def change
    create_table :restricted_brands do |t|
      t.string :name
      t.boolean :restricted
      t.boolean :transparency
      t.boolean :private_label
      t.boolean :intellectual_property
      t.boolean :parallel_import
      t.boolean :hard_gated
      t.integer :source
      t.text :general_info

      t.timestamps
    end
  end
end
