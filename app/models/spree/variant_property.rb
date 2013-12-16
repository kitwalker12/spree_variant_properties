module Spree
  class VariantProperty < ActiveRecord::Base
    belongs_to :variant, class_name: 'Spree::Variant'
    belongs_to :property, class_name: 'Spree::Property'

    validates :property, presence: true

    def property_name
      property.name if property
    end

    def property_name=(name)
      unless name.blank?
        unless property = Spree::Property.find_by(name: name)
          property = Spree::Property.create(name: name, presentation: name)
        end
        self.property = property
      end
    end
  end
end
