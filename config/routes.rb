Rails.application.routes.draw do

	resources :emergencies, only: [:create]
	match '*undefined_path', to: 'errors#raise_404_not_found', via: :
	
end
