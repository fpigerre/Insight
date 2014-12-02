class DashboardController < ApplicationController
  require 'json'
  require 'net/http'
  require 'open-uri'
  require 'optparse'
  require 'money'
  require 'money/bank/google_currency'

  layout '_dashboard.html.erb'
  before_action :authenticate_user!

  # GET /dash
  # GET /dash.json
  def index
    @price = get_ex('http://api.bitcoincharts.com/v1/markets.json', 'bitstampUSD')
    $usd = get_currency('USD')
    $eur = get_currency('EUR')
    $cny = get_currency('CNY')
    respond_to do |format|
      format.html # index.html.erb.erb
    end
  end

  def get_ex(url, symbol)
    begin
      open(url) do |d|
        json = JSON.parse(d.read)
        json.each do |a|
          a.each do |k, v|
            if k == 'symbol' and v == symbol
              return true, a
            end
          end
        end
        return false, 'bity Error: Symbol not found in BitCoin API.'
      end
    rescue SocketError => e
      return false, 'bity Error: Could not connect to BitCoin Charts API.'
    end
  end

  def get_currency(code)
    Money::Bank::GoogleCurrency.ttl_in_seconds = 300
    Money.default_bank = Money::Bank::GoogleCurrency.new
    money = Money.new(1_00, code) # Amount is in cents
    money.exchange_to(:AUD)
  end
end