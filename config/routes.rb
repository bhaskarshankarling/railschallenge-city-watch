Rails.application.routes.draw do

	match 'emergencies/new', to: 'errors#raise_404_not_found', via: :all
	match 'responders/new', to: 'errors#raise_404_not_found', via: :all
	
	resources :emergencies, only: [:create]
	match 'emergencies/', to: 'emergencies#index', via: :get
	match 'emergencies/:code', to: 'emergencies#show', as: :emergency, via: :get
	{ patch: 'update', put: 'update' }.each do |method, action|
		match 'emergencies/:code', to: "emergencies##{action}", via: method
	end

	resources :responders, only: [:create]
	{ patch: 'update', put: 'update' }.each do |method, action|
		match 'responders/:name', to: "responders##{action}", via: method
	end

	match '*undefined_path', to: 'errors#raise_404_not_found', via: :all

end
