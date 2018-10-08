Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'simpl#front_page'

  get '/sim_match' => 'simpl#sim_match'
end
