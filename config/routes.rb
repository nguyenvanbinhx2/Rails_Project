Rails.application.routes.draw do
  scope"(:locale)", locale:/en|vi/ do
    resource :static_pages
    get "static_pages/home"
    get "static_pages/about"
    get "static_pages/contact"
    get "static_pages/help"
  end
end
