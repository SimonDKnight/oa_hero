# require 'csv'

# restricted_brands_csv_file = Rails.root.join('db', 'data', '15_july_restricted_brands_supabase.csv')
# suppliers_csv_file = Rails.root.join('db', 'data', '15_july_suppliers_supabase.csv')
#sql was harder to sanitise hence chosen csv because it safely handles quotes and special characters like Doctor's Best

# CSV.foreach(restricted_brands_csv_file, headers: true) do |row|
# 	RestrictedBrand.create!(
# 		name: row['name'],
# 		restricted: row['restricted'].to_s.downcase == 'true',
# 		transparency: row['transparency'].to_s.downcase == 'true',
# 		private_label: row['private_label'].to_s.downcase == 'true',
# 		intellectual_property: row['intellectual_property'].to_s.downcase == 'true',
# 		parallel_import: row['parallel_import'].to_s.downcase == 'true',
# 		hard_gated: row['hard_gated'].to_s.downcase == 'true',
# 		source: row['source'].presence,
# 		general_info: row['general_info']
# 	)
# end
#
# CSV.foreach(suppliers_csv_file, headers: true) do |row|
# 	Supplier.create!(
# 		lc_name: row['lc_name'],
# 		name: row['name'],
# 		url: row['url'],
# 		reclaim_vat: row['reclaim_vat'],
# 		vat_number: row['vat_number'],
# 		customer_service_email: row['customer_service_email'],
# 		qty_limit: row['qty_limit'],
# 		order_limit: row['order_limit'],
# 		allow_resellers: row['allow_resellers'],
# 		vat_invoice_info: row['vat_invoice_info'],
# 		info: row['info']
# 	)
# end
