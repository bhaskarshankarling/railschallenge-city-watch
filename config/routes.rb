Rails.application.routes.draw do
	
	match '*undefined_path', to: 'errors#raise_404_not_found', via: :all
end
