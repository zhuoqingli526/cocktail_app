class HomeController < ApplicationController
  def index
    render({ :template => "home_templates/home"})
  end
end
