Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :products do
      resources :variants do
        resources :variant_properties
      end
    end
  end
end
