class WelcomeController < ApplicationController
  def index
  end
  def splash
    render 'welcome/splash', layout: false
  end
end
