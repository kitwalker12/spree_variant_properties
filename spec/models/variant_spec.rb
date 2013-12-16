require 'spec_helper'

describe Spree::Variant do
  context "properties" do
    let(:variant) { create(:variant) }

    it "should properly assign properties" do
      variant.set_property('the_prop', 'value1')
      variant.property('the_prop').should == 'value1'

      variant.set_property('the_prop', 'value2')
      variant.property('the_prop').should == 'value2'
    end

    it "should not create duplicate properties when set_property is called" do
      expect {
        variant.set_property('the_prop', 'value2')
        variant.save
        variant.reload
      }.not_to change(variant.properties, :length)

      expect {
        variant.set_property('the_prop_new', 'value')
        variant.save
        variant.reload
        variant.property('the_prop_new').should == 'value'
      }.to change { variant.properties.length }.by(1)
    end

    # Regression test for #2455
    it "should not overwrite properties' presentation names" do
      Spree::Property.where(:name => 'foo').first_or_create!(:presentation => "Foo's Presentation Name")
      variant.set_property('foo', 'value1')
      variant.set_property('bar', 'value2')
      Spree::Property.where(:name => 'foo').first.presentation.should == "Foo's Presentation Name"
      Spree::Property.where(:name => 'bar').first.presentation.should == "bar"
    end
  end
end