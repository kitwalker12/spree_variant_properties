module Spree
  module Admin
    class VariantPropertiesController < ResourceController
      belongs_to 'spree/variant', :find_by => :id
      before_filter :find_product
      before_filter :find_properties
      before_filter :setup_property, :only => [:index]

      private
        def find_product
          @product = Spree::Product.find_by(permalink: params[:product_id])
        end

        def find_properties
          @properties = Spree::Property.pluck(:name)
        end

        def setup_property
          @variant.variant_properties.build
        end

        def location_after_destroy
          edit_admin_product_variant_url(@product, @variant)
        end

        def location_after_save
          edit_admin_product_variant_url(@product, @variant)
        end
    end
  end
end
