class CocktailCommentsController < ApplicationController
  def index
    matching_cocktail_comments = CocktailComment.all

    @list_of_cocktail_comments = matching_cocktail_comments.order({ :created_at => :desc })

    render({ :template => "cocktail_comments/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_cocktail_comments = CocktailComment.where({ :id => the_id })

    @the_cocktail_comment = matching_cocktail_comments.at(0)

    render({ :template => "cocktail_comments/show" })
  end

  def create
    the_cocktail_comment = CocktailComment.new
    the_cocktail_comment.cocktail_id = params.fetch("query_cocktail_id")
    the_cocktail_comment.user_id = params.fetch("query_user_id")

    if the_cocktail_comment.valid?
      the_cocktail_comment.save
      redirect_to("/cocktail_comments", { :notice => "Cocktail comment created successfully." })
    else
      redirect_to("/cocktail_comments", { :alert => the_cocktail_comment.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_cocktail_comment = CocktailComment.where({ :id => the_id }).at(0)

    the_cocktail_comment.cocktail_id = params.fetch("query_cocktail_id")
    the_cocktail_comment.user_id = params.fetch("query_user_id")

    if the_cocktail_comment.valid?
      the_cocktail_comment.save
      redirect_to("/cocktail_comments/#{the_cocktail_comment.id}", { :notice => "Cocktail comment updated successfully."} )
    else
      redirect_to("/cocktail_comments/#{the_cocktail_comment.id}", { :alert => the_cocktail_comment.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_cocktail_comment = CocktailComment.where({ :id => the_id }).at(0)

    the_cocktail_comment.destroy

    redirect_to("/cocktail_comments", { :notice => "Cocktail comment deleted successfully."} )
  end
end
