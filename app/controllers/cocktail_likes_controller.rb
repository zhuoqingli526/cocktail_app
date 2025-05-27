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
      redirect_to("/cocktail_likes", { :notice => "Cocktail like created successfully." })
    else
      redirect_to("/cocktail_likes", { :alert => the_cocktail_like.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_cocktail_like = CocktailLike.where({ :id => the_id }).at(0)

    the_cocktail_like.cocktail_id = params.fetch("query_cocktail_id")
    the_cocktail_like.user_id = params.fetch("query_user_id")

    if the_cocktail_like.valid?
      the_cocktail_like.save
      redirect_to("/cocktail_likes/#{the_cocktail_like.id}", { :notice => "Cocktail like updated successfully."} )
    else
      redirect_to("/cocktail_likes/#{the_cocktail_like.id}", { :alert => the_cocktail_like.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_cocktail_like = CocktailLike.where({ :id => the_id }).at(0)

    the_cocktail_like.destroy

    redirect_to("/cocktail_likes", { :notice => "Cocktail like deleted successfully."} )
  end
end
