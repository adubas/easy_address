# frozen_string_literal: true

class UserAddress < ApplicationRecord
  validates :zip_code, uniqueness: { scope: :name, message: 'CEP and name must be unique' }
  validates :name, :zip_code, presence: true

  def self.create_or_update(user_info, address_info)
    address = UserAddress.find_or_initialize_by(zip_code: user_info[:cep], name: user_info[:name])
    address.update(
      street: address_info['logradouro'],
      neighborhood: address_info['bairro'],
      city: address_info['localidade'],
      state: address_info['uf'],
      complement: address_info['complemento'],
      ibge: address_info['ibge'],
      gia: address_info['gia'],
      ddd: address_info['ddd'],
      siafi: address_info['siafi']
    )

    address
  end
end
