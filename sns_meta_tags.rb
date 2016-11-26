class SnsMetaTags
  attr_accessor :url, :price, :user_agent

  GOOGLE_BOT_SMARTPHONE_USER_AGENT = "Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"

  def initialize(url, user_agent = GOOGLE_BOT_SMARTPHONE_USER_AGENT)
    # @html = read(url, usesr_agent)
  end



  private
  def read(url, user_agent)
    charset = nil
    html = open(url, "User-Agent" => user_agent) do |f|
      charset = f.charset
      f.read # htmlを読み込んで変数htmlに渡す
    end

    # htmlをパース(解析)してオブジェクトを生成
    doc = Nokogiri::HTML.parse(html, nil, charset)
  end

end
