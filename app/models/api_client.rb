class ApiClient
  API_ENDPOINT = 'https://api.getgalore-staging.com/v1/events'.freeze
  API_KEY = 'y7LfciquwtdT4gCQgnNMzQxx'.freeze

  def initialize(page, per_page)
    @url = URI(API_ENDPOINT)
    @request = Net::HTTP::Get.new(url.to_s + "?page=#{page}&count=#{per_page}")
    set_request_headers
  end

  def get
    http = Net::HTTP.new(url.hostname, url.port)
    http.use_ssl = true

    http.request(request)
  end

  private

  attr_accessor :url, :request

  def set_request_headers
    request['Api-Key'] = API_KEY
    request['Api-Version'] = '1.25'
    request['Timezone'] = 'Pacific Time (US & Canada)'
    request['Content-Type'] = 'application/json'
  end
end
