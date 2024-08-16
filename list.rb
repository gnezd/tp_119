require 'net/http'
require 'pry'
require 'json'

uri = URI('https://service119.tfd.gov.tw/service119/citizenCase/caseList')
if (ARGV[0].to_f > 0.0) && (ARGV[0].to_f < 1.0)
  comment = ARGV[0].to_f
  params = {'t': ARGV[0].to_f.to_s} unless defined? params
end
params = {'t': rand.to_s} unless defined? params
req = Net::HTTP::Post.new uri.path, params

http = Net::HTTP.new uri.host, uri.port
http.use_ssl= true
result = http.request req
binding.pry
cases = JSON.parse result.body.force_encoding('UTF-8')
cases['comment'] = "t = #{comment}" if comment
puts JSON.pretty_generate(cases)