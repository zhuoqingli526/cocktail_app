class CocktailLikesController < ApplicationController
  def index
    matching_cocktail_likes = CocktailLike.all

    @list_of_cocktail_likes = matching_cocktail_likes.order({ :created_at => :desc })

    render({ :template => "cocktail_likes/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_cocktail_likes = CocktailLike.where({ :id => the_id })

    @the_cocktail_like = matching_cocktail_likes.at(0)

    render({ :template => "cocktail_likes/show" })
  end

  def create
    the_cocktail_like = CocktailLike.new
    the_cocktail_like.cocktail_id = params.fetch("query_cocktail_id")
    the_cocktail_like.user_id = params.fetch("query_user_id")

    if the_cocktail_like.valid?
      the_cocktail_like.save
      redirect_to("/cocktails/#{the_cocktail_like.cocktail_id}", { :notice => "Like created successfully." })
    else
      redirect_to("/cocktails/#{the_cocktail_like.cocktail_id}", { :alert => the_cocktail_like.errors.full_messages.to_sentence })
    end
  end


  def destroy
    like = CocktailLike.find(params.fetch("path_id"))
    cocktail_id = like.cocktail_id

    like.destroy

    redirect_to("/cocktails/#{cocktail_id}", notice: "Like deleted successfully.")
  end
end
