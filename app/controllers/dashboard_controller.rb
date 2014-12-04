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
    @price = ModuleHelper.get_ex('http://api.bitcoincharts.com/v1/markets.json', 'bitstampUSD')
    $usd = ModuleHelper.get_currency('USD')
    $eur = ModuleHelper.get_currency('EUR')
    $cny = ModuleHelper.get_currency('CNY')
    $gbp = ModuleHelper.get_currency('GBP')
    $news = ModuleHelper.get_news('2014', 'December', '4').gsub('\n', '<br>').gsub(';', '')
    respond_to do |format|
      format.html # index.html.erb.erb
    end
  end
end