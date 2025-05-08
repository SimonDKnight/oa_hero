class CreateLicenses < ActiveRecord::Migration[8.0]
  def change
    create_table :licenses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :license_key
      t.string :plan
      t.string :stripe_customer_id
      t.string :stripe_subscription_id
      t.datetime :expires_at

      t.timestamps
    end
  end
end
