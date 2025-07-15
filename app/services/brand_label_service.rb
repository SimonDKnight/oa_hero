class BrandLabelService
	class << self
		def fetch_labels(brand_name)
			return nil unless brand_name.present?

			result = RestrictedBrand.find_by("name ILIKE ?", "%#{brand_name}%")
			return nil unless result

			{
				transparency: result.transparency,
				intellectualProperty: result.intellectual_property,
				parallelImport: result.parallel_import,
				privateLabel: result.private_label,
				hardGated: result.hard_gated,
				generalInfo: result.general_info
			}
		end
	end
end
