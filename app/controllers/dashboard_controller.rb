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
    time = Time.new
    @price = ModuleHelper.get_bitcoin
    $usd = ModuleHelper.get_currency('USD')
    $eur = ModuleHelper.get_currency('EUR')
    $cny = ModuleHelper.get_currency('CNY')
    $gbp = ModuleHelper.get_currency('GBP')
    $news = ModuleHelper.get_news(time.year.to_s, Date::MONTHNAMES[Date.today.month], time.day.to_s).gsub('\n', '<br>').gsub(';', '')
    $likes = ModuleHelper.get_likes
    respond_to do |format|
      format.html # index.html.erb.erb
    end
  end
end