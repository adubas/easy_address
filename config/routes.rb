# frozen_string_literal: true

Rails.application.routes.draw do
  post '/fetch_address', to: 'addresses#create', defaults: { format: :json }
end
