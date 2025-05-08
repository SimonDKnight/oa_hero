class RemoveLicenseFieldsFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :plan, :string
    remove_column :users, :stripe_customer_id, :string
    remove_column :users, :stripe_subscription_id, :string
    remove_column :users, :paid, :boolean
  end
end
