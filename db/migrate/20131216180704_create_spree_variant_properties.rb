class CreateSpreeVariantProperties < ActiveRecord::Migration
  def change
    create_table :spree_variant_properties do |t|
      t.references :variant, index: true
      t.references :property, index: true
      t.text :value

      t.timestamps
    end
  end
end
