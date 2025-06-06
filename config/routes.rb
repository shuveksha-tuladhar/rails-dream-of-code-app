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
      post '/students', to: 'students#create'
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
end
