class CreateSuppliers < ActiveRecord::Migration[8.0]
  def change
    create_table :suppliers do |t|
      t.string :lc_name
      t.string :name
      t.text :url
      t.string :reclaim_vat
      t.string :vat_number
      t.string :customer_service_email
      t.text :qty_limit
      t.text :order_limit
      t.boolean :allow_resellers
      t.text :vat_invoice_info
      t.text :info

      t.timestamps
    end
  end
end
