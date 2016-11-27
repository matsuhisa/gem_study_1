require 'net/http'
class MyHttp
  def my_method target_url
    uri = URI.parse(target_url)
    req = Net::HTTP::Get.new(uri.path)
    res = Net::HTTP.start(uri.host, uri.port) {|http| http.request(req) }
    if res.code == "200"
      "OK"
    else
      "Status code: #{res.code}"
    end
  end
end
