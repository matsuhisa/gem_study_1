require 'open-uri'
require 'nokogiri'

class SnsMetaTags
  attr_accessor :url, :user_agent

  GOOGLE_BOT_SMARTPHONE = "Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"

  def initialize(url, user_agent = GOOGLE_BOT_SMARTPHONE)
    @url = url
    @user_agent = user_agent
    page_read
  end

  def foo
    @url
  end

  def og_title
    @doc.xpath('//meta[@property="og:title"]').map {|item| item.attribute('content').value }
  end

  def og_images
    @doc.xpath('//meta[@property="og:image"]').map {|item| item.attribute('content').value }
  end

  def canonical
    @doc.xpath('//link[@rel="canonical"]').attribute('href').value if @doc && @doc.xpath('//link[@rel="canonical"]').size.nonzero?
  end

  private
  def page_read(url = @url, user_agent = GOOGLE_BOT_SMARTPHONE)
    begin
      charset = nil
      html = open(url) do |f|
        charset = f.charset
        f.read
      end
      @doc = Nokogiri::HTML.parse(html, nil, charset)
    rescue OpenURI::HTTPError
    end
  end

end
