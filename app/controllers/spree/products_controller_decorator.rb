Spree::ProductsController.class_eval do
  before_filter :load_product, only: [:show, :show_variant_properties]

  respond_to :html, except: :show_variant_properties

  respond_to :js, only: :show_variant_properties
 
  def show
    return unless @product

    @variants = @product.variants_including_master.active(current_currency).includes([:option_values, :images])
    @product_properties = @product.product_properties.includes(:property)

    related_products_ids = @product.relations.pluck(:related_to_id)
    @related_products = Spree::Product.find_all_by_id(related_products_ids)

    @variant_properties = @product.variants.first.variant_properties if @product.variants.first

    referer = request.env['HTTP_REFERER']
    if referer
      begin
        referer_path = URI.parse(request.env['HTTP_REFERER']).path
        # Fix for #2249
      rescue URI::InvalidURIError
        # Do nothing
      else
        if referer_path && referer_path.match(/\/t\/(.*)/)
          @taxon = Spree::Taxon.find_by_slug($1)
        else
          @taxon = Spree::Product.find_by_slug(params[:id]).taxons.first
        end
      end
    end
  end

  def show_variant_properties
    @product_properties = @product.product_properties.includes(:property)
    @variant_properties = @product.variants.find(params[:variant_id]).variant_properties
    respond_with @variant_properties
  end
end
