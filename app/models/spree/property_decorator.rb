module Spree
  Property.class_eval do
    has_many :variant_properties, dependent: :delete_all
    has_many :variants, through: :variant_properties
  end
end