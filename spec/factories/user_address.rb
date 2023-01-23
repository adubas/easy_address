# frozen_string_literal: true

FactoryBot.define do
  factory :user_address do
    zip_code { '02418100' }
    name { 'JOSÉ' }
    street { 'Rua Bento Gonçalves' }
    neighborhood { 'Centro' }
    city { 'Camaquã' }
    state { 'RS' }
    complement { '1320' }
    ibge { '4303509' }
    gia { nil }
    ddd { '53' }
    siafi { nil }
  end
end
