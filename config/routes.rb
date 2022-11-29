Studysquare::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users

  get '/instituties/:type', to: 'institutes#index'

  resources :institutes, path: 'instituties' do
    resources :faculties, path: 'faculteiten' do
      resources :faculty_programs, path: 'opleidingen' do
        resources :program_courses, path: 'vakken' do
          resources :courses, shallow: true, path: 'cursussen' do
            resource :registration, path: 'registratie'
          end
        end
      end
    end
  end





  namespace :manager do
    resources :program_courses
    resources :tutors
    resources :courses do
      resources :timeslots, only: :new
    end
    resources :messages
    resources :timeslots, except: :new
    resources :registrations
  end

  resources :orders, path: 'bestellingen'
  resources :payments, path: 'betalingen'
  resources :timeslots, path: 'tijdvakken'
  resource :timetable, path: 'rooster'
  
  # Contact form for exam training
  resources "contacts", only: [:new, :create]

  # Mailer redirect only
  resources :faculty_programs, only: :show

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root to: 'high_voltage/pages#show', id: 'home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

