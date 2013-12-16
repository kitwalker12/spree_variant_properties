module Spree
  Admin::VariantsController.class_eval do
    update.before :update_before

    protected
      def update_before
        return unless params[:clear_variant_properties]
        params[:variant] ||= {}
      end
  end
end