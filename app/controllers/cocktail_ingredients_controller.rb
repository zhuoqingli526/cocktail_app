class CocktailIngredientsController < ApplicationController
  def index
    matching_cocktail_ingredients = CocktailIngredient.all

    @list_of_cocktail_ingredients = matching_cocktail_ingredients.order({ :created_at => :desc })

    render({ :template => "cocktail_ingredients/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_cocktail_ingredients = CocktailIngredient.where({ :id => the_id })

    @the_cocktail_ingredient = matching_cocktail_ingredients.at(0)

    render({ :template => "cocktail_ingredients/show" })
  end

  def create
    the_cocktail_ingredient = CocktailIngredient.new
    the_cocktail_ingredient.cocktail_id = params.fetch("query_cocktail_id")
    the_cocktail_ingredient.ingredient_id = params.fetch("query_ingredient_id")
    the_cocktail_ingredient.unit_ml = params.fetch("query_unit_ml")

    if the_cocktail_ingredient.valid?
      the_cocktail_ingredient.save
      redirect_to("/cocktail_ingredients", { :notice => "Cocktail ingredient created successfully." })
    else
      redirect_to("/cocktail_ingredients", { :alert => the_cocktail_ingredient.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_cocktail_ingredient = CocktailIngredient.where({ :id => the_id }).at(0)

    the_cocktail_ingredient.cocktail_id = params.fetch("query_cocktail_id")
    the_cocktail_ingredient.ingredient_id = params.fetch("query_ingredient_id")
    the_cocktail_ingredient.unit_ml = params.fetch("query_unit_ml")

    if the_cocktail_ingredient.valid?
      the_cocktail_ingredient.save
      redirect_to("/cocktail_ingredients/#{the_cocktail_ingredient.id}", { :notice => "Cocktail ingredient updated successfully."} )
    else
      redirect_to("/cocktail_ingredients/#{the_cocktail_ingredient.id}", { :alert => the_cocktail_ingredient.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_cocktail_ingredient = CocktailIngredient.where({ :id => the_id }).at(0)

    the_cocktail_ingredient.destroy

    redirect_to("/cocktail_ingredients", { :notice => "Cocktail ingredient deleted successfully."} )
  end
end
