
Deface::Override.new(:virtual_path => 'spree/products/_properties',
  :name => 'add_properties_for_each_variant',
  :replace => "table#product-properties tbody",
  :text => "
    <% if @variant_properties.present? %>
      <% @variant_properties.each do |variant| %>
        <% css_class = cycle('even', 'odd', :name => 'properties') %>
        <tr class='<%= css_class %>'>
          <td><strong><%= variant.property(:properties).name %></strong></td>
          <td><%= variant.value %></td>
        </tr>
      <% end %>
    <% else %>
      <% @product_properties.each do |product_property| %>
        <% css_class = cycle('even', 'odd', :name => 'properties') %>
        <tr class='<%= css_class %>'>
          <td><strong><%= product_property.property.presentation %></strong></td>
          <td><%= product_property.value %></td>
        </tr>
      <% end %>
    <% end %>
    <% reset_cycle('properties') %>
  ")
