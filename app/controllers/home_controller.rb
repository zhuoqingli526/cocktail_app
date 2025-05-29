class HomeController < ApplicationController

  skip_before_action(:authenticate_user!, { :only => [:index] })
  
  def index
    render({ :template => "home_templates/home"})
  end
end
