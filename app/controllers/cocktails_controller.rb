class CocktailsController < ApplicationController
  skip_before_action(:authenticate_user!, { :only => [:index] })
  def index
    matching_cocktails = Cocktail.all

    @list_of_cocktails = matching_cocktails.order({ :created_at => :desc })

    render({ :template => "cocktails/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_cocktails = Cocktail.where({ :id => the_id })

    @the_cocktail = matching_cocktails.at(0)

    render({ :template => "cocktails/show" })
  end

  def create
    the_cocktail = Cocktail.new
    the_cocktail.cocktail_name = params.fetch("query_cocktail_name")
    the_cocktail.description = params.fetch("query_description")
    the_cocktail.instructions = params.fetch("query_instructions")
    the_cocktail.abv = params.fetch("query_abv")
    the_cocktail.taste = params.fetch("query_taste")
    the_cocktail.image_url = params.fetch("query_image_url")
    the_cocktail.user_id = params.fetch("query_user_id")

    if the_cocktail.valid?
      the_cocktail.save
      redirect_to("/cocktails", { :notice => "Cocktail created successfully." })
    else
      redirect_to("/cocktails", { :alert => the_cocktail.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_cocktail = Cocktail.where({ :id => the_id }).at(0)

    the_cocktail.cocktail_name = params.fetch("query_cocktail_name")
    the_cocktail.description = params.fetch("query_description")
    the_cocktail.instructions = params.fetch("query_instructions")
    the_cocktail.abv = params.fetch("query_abv")
    the_cocktail.taste = params.fetch("query_taste")
    the_cocktail.image_url = params.fetch("query_image_url")
    the_cocktail.user_id = params.fetch("query_user_id")

    if the_cocktail.valid?
      the_cocktail.save
      redirect_to("/cocktails/#{the_cocktail.id}", { :notice => "Cocktail updated successfully."} )
    else
      redirect_to("/cocktails/#{the_cocktail.id}", { :alert => the_cocktail.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_cocktail = Cocktail.where({ :id => the_id }).at(0)

    the_cocktail.destroy

    redirect_to("/cocktails", { :notice => "Cocktail deleted successfully."} )
  end
end
