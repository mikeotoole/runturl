Rails.application.routes.draw do
  root 'short_urls#new'
  resources :short_urls, path: '', only: [:new, :create]
  get '/:base62_id' => 'short_urls#show'
end
