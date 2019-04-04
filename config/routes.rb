Rails.application.routes.draw do
  get 'sessions/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :report_viewer do
    collection do
      post 'view_report', to: 'report_viewer#view_report'
    end
  end
  resources :teams
  resources :profiles
  resources :notes do
    collection do
      post 'change_team_and_dates', to: 'notes#change_team_and_dates'
    end
  end
  resources :user_settings do
    collection do
      put 'change_password', to: 'user_settings#change_password'
    end
  end
  resources :new_user
  resources :users do
    collection do
      put ':id/reset_password', to: 'users#reset_password'
    end
  end
  resources :analytics do
    collection do
      post 'change_team_and_dates', to: 'analytics#change_team_and_dates'
    end
  end
  resources :sessions do
    collection do
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy'
    end
  end
  resources :test_runs
  resources :file_uploader do
    collection do
      post 'process_file', to: 'file_uploader#process_file'
      put 'upload', to: 'file_uploader#upload'
    end
  end
  root 'report_viewer#index'

end
