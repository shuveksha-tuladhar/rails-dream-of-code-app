Rails.application.routes.draw do
  resources :students
  resources :mentors
  resources :enrollments
  resources :mentor_enrollment_assignments
  resources :lessons
  resources :courses
  resources :coding_classes

  namespace :api do
    namespace :v1 do
      get '/courses', to: 'courses#index'
      get '/courses/:course_id/enrollments', to: 'enrollments#index'
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  resources :courses do
    resources :submissions
  end

  resources :trimesters, only: [:edit, :update]

  get "/trimesters", to: "trimesters#index"
  get "/trimesters/:id", to: "trimesters#show"
  get "/dashboard", to: "admin_dashboard#index"
  get "/api/v1/courses", to: "courses#indexApi"
  get "/api/v1/courses/:id", to: "courses#showApi"

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
