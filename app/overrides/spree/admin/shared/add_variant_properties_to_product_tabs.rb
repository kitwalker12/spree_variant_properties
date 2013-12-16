Deface::Override.new(:virtual_path => 'spree/admin/shared/_product_tabs',
  :name => 'add_variant_properties_to_product_tabs',
  :insert_bottom => "[data-hook='admin_product_tabs']",
  :text => "
    <% if !@variant.blank? and can?(:admin, Spree::Variant)%>
      <%= content_tag :li, :class => ('active' if current == 'Variant Properties') do %>
        <%= link_to_with_icon 'icon-tasks', 'VARIANT PROPERTIES', admin_product_variant_variant_properties_url(@product, @variant) %>
      <% end %>
    <% end %>
  ")