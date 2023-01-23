# frozen_string_literal: true

class AddressApi
  class Error < StandardError; end

  def self.call(cep)
    conn = Faraday.new(url: 'https://viacep.com.br/ws/') do |connection|
      connection.request :retry, max: 3,
                                 interval: 0.05,
                                 interval_randomness: 0.5,
                                 backoff_factor: 2
    end

    response = conn.get("#{cep}/json/")

    raise AddressApi::Error, "Failed to retrieve address information for CEP #{cep}" unless response.success?

    JSON.parse(response.body)
  rescue Faraday::TimeoutError => _e
    raise AddressApi::Error, "Timeout error occurred while retrieving address information for CEP #{cep}"
  rescue Faraday::ConnectionFailed => _e
    raise AddressApi::Error, "Timeout error occurred while retrieving address information for CEP #{cep}"
  end
end
