require 'net/http'
require 'uri'
require 'json'

API_KEY = ENV['PEOPLEHR_API_KEY']

def load_members
  send_request('https://api.peoplehr.net/Employee', {
      'Action': 'GetAllEmployeeDetail',
      'APIKey': API_KEY,
      'IncludeLeavers': 'false'
  })['Result'].map { |data| Member.new(data) }
end

def load_holidays(employee_id)
  send_request('https://api.peoplehr.net/Holiday', {
      'Action': 'GetHolidayDetail',
      'APIKey': API_KEY,
      'EmployeeId': employee_id
  })['Result'].map { |data| Holiday.new(data) }

end

def update_holidays(employee_id, days)
  send_request('https://api.peoplehr.net/HolidayEntitlements', {
    'Action': 'UpdateHolidayEntitlement',
    'APIKey': API_KEY,
    'EmployeeId': employee_id,
    'EntitlementThisYear': days.to_f.to_s,
    'ReasonForChange': 'Update service period'
  })
end

def send_request(url, data)
  uri = URI(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
  req.body = data.to_json
  res = http.request(req)
  JSON.parse(res.body)
rescue => e
  p "Error #{e.message}"
  {}
end