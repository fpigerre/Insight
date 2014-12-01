class DashboardController < ApplicationController
  layout '_dashboard.html.erb'
  before_action :authenticate_user!

  # GET /dash
  # GET /dash.json
  def index
    respond_to do |format|
      format.html # index.html.erb.erb
    end
  end
end