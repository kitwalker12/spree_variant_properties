require 'spec_helper'

describe Spree::Admin::VariantsController do
  stub_authorization!

  context "adding properties to a variant" do
    let!(:variant) { create(:variant) }
    specify do
      spree_put :update, :id => variant.product.to_param, :variant => { :variant_properties_attributes => { "1" => { :property_name => "Foo", :value => "bar" } } }
      flash[:success].should == "Product #{variant.name.inspect} has been successfully updated!"
    end

  end
end