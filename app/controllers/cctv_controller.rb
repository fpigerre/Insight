class CctvController < ApplicationController
  layout '_cctv.html.erb'
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html # index.html.erb.erb
    end
  end
end