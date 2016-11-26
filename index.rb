require 'open-uri'
require 'nokogiri'

GOOGLE_BOT_SMARTPHONE_USER_AGENT = "Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"

url = "http://www.yahoo.co.jp/"


charset = nil
html = open(url, "User-Agent" => GOOGLE_BOT_SMARTPHONE_USER_AGENT) do |f|
  charset = f.charset # 文字種別を取得
  f.read # htmlを読み込んで変数htmlに渡す
end

# htmlをパース(解析)してオブジェクトを生成
doc = Nokogiri::HTML.parse(html, nil, charset)

puts charset
puts doc.title

doc.xpath('//meta[@property="og:title"]').each do |og_title|
  puts og_title.attribute('content').value
end

doc.xpath('//meta[@property="og:image"]').each do |og_image|
  puts og_image.attribute('content').value
end

doc.xpath('//link[@rel="canonical"]').each do |canonical|
  puts canonical.attribute('href').value
end
