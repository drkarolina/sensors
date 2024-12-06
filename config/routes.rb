# frozen_string_literal: true

Rails.application.routes.draw do
  resources :sensor_data, only: %i[create index]
end
