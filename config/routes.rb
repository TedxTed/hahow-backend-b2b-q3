Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  mount EndpointApi => EndpointApi::PREFIX
  mount GrapeSwaggerRails::Engine => '/RailsAPI'
end
