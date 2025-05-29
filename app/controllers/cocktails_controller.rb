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

  def new
    render({ :template => "cocktails/new" })
  end

  # POST /insert_cocktail
  def create
    the_cocktail = Cocktail.new
    the_cocktail.cocktail_name = params.fetch("the_cocktail_name")
    the_cocktail.description = params.fetch("the_description")
    the_cocktail.instructions = params.fetch("the_instructions")
    the_cocktail.abv = params.fetch("the_abv")
    the_cocktail.taste = params.fetch("the_taste")
    the_cocktail.user_id = current_user.id
    the_cocktail.image_url = params.fetch("the_image_url")

    ActiveRecord::Base.transaction do
      the_cocktail.save!

      names = params.fetch("ingredient_names",[])
      mls = params.fetch("ingredient_unit_mls", [])
      cat_ids = params.fetch("ingredient_category_ids",[])
      ingredient_abvs = params.fetch("ingredient_abvs", [])

      names.each_index do |idx|
        next if names[idx].blank?  # 跳过空行

        # 2.1) Ingredient：有就复用，没有就建
        ingredient = Ingredient.where({ :name => names[idx].strip }).first
        unless ingredient
          ingredient = Ingredient.create!(
            :name                   => names[idx].strip,
            :abv                    => ingredient_abvs[idx],
            :ingredient_category_id => cat_ids[idx],
            :description            => "" # 用户此步不填描述
          )
        end

        # 2.2) 桥接表
        CocktailIngredient.create!(
          :cocktail_id   => the_cocktail.id,
          :ingredient_id => ingredient.id,
          :unit_ml       => mls[idx]
        )
      end
    end

    # 3) 成功跳到 show；失败回 new
    redirect_to("/cocktails/#{the_cocktail.id}", { :notice => "Cocktail created!" })
  rescue => e
    redirect_to("/cocktails/new", { :alert => "Save failed: #{e.message}" })
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
