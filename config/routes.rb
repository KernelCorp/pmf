Rails.application.routes.draw do
  post 'main/send_feedback'
  root 'main#index'
end
