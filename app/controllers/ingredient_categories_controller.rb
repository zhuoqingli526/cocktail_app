class IngredientCategoriesController < ApplicationController
  def index
    matching_ingredient_categories = IngredientCategory.all

    @list_of_ingredient_categories = matching_ingredient_categories.order({ :created_at => :desc })

    render({ :template => "ingredient_categories/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_ingredient_categories = IngredientCategory.where({ :id => the_id })

    @the_ingredient_category = matching_ingredient_categories.at(0)

    render({ :template => "ingredient_categories/show" })
  end

  def create
    the_ingredient_category = IngredientCategory.new
    the_ingredient_category.name = params.fetch("query_name")

    if the_ingredient_category.valid?
      the_ingredient_category.save
      redirect_to("/ingredient_categories", { :notice => "Ingredient category created successfully." })
    else
      redirect_to("/ingredient_categories", { :alert => the_ingredient_category.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_ingredient_category = IngredientCategory.where({ :id => the_id }).at(0)

    the_ingredient_category.name = params.fetch("query_name")

    if the_ingredient_category.valid?
      the_ingredient_category.save
      redirect_to("/ingredient_categories/#{the_ingredient_category.id}", { :notice => "Ingredient category updated successfully."} )
    else
      redirect_to("/ingredient_categories/#{the_ingredient_category.id}", { :alert => the_ingredient_category.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_ingredient_category = IngredientCategory.where({ :id => the_id }).at(0)

    the_ingredient_category.destroy

    redirect_to("/ingredient_categories", { :notice => "Ingredient category deleted successfully."} )
  end
end
