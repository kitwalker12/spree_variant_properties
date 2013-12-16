module Spree
  Variant.class_eval do
    has_many :variant_properties, dependent: :destroy
    has_many :properties, through: :variant_properties

    accepts_nested_attributes_for :variant_properties, allow_destroy: true, reject_if: lambda { |vp| vp[:property_name].blank? }

    def property(property_name)
      return nil unless prop = properties.find_by(name: property_name)
      variant_properties.find_by(property: prop).try(:value)
    end

    def set_property(property_name, property_value)
      ActiveRecord::Base.transaction do
        property = Spree::Property.where(name: property_name).first_or_create!(presentation: property_name)
        variant_property = Spree::VariantProperty.where(variant: self, property: property).first_or_initialize
        variant_property.value = property_value
        variant_property.save!
      end
    end
  end
end