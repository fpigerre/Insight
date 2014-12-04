module ModuleHelper
  require 'nokogiri'

  def self.get_bitcoin
    uri = URI.parse('https://www.bitstamp.net/api/ticker/')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    response.body
    return JSON.parse(response.body)['last']
  end

  def self.get_currency(code)
    Money::Bank::GoogleCurrency.ttl_in_seconds = 300
    Money.default_bank = Money::Bank::GoogleCurrency.new
    money = Money.new(1_00, code) # Amount is in cents
    money.exchange_to(:AUD)
  end

  def self.get_news(year, month, day)
    uri = URI.encode('http://en.wikipedia.org/w/api.php?format=json&action=query&titles=Portal:Current_events/' + year + '_' + month + '_' + day + '&prop=revisions&rvprop=content')
    body = Net::HTTP.get(URI.parse(uri))
    text = body.match(/<!-- All news items below this line -->(.*)<!-- All news items above this line -->/m)[1].strip
    text_two = text.gsub('[[', '')
    text_three = text_two.gsub(']]', '')
    text_four = text_three.gsub('\n**', ':<br>')
    text_five = text_four.gsub('\n;', '<h3>')
    return text_five.gsub('\n*', '</h3>')
  end

  def self.get_likes
    page = Nokogiri::HTML(open('https://www.facebook.com/jj4pm', {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}))
    links = page.css('span._52id')
    print links
    return links.text
  end
end