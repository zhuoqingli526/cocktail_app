# lib/tasks/slurp.rake

require "csv"

namespace :slurp do
  desc "Import all CSV data into the database"
  task all: :environment do

    puts "Deleting existing records..."
    FollowRequest.delete_all
    CocktailComment.delete_all
    CocktailLike.delete_all
    CocktailIngredient.delete_all
    Cocktail.delete_all
    Ingredient.delete_all
    IngredientCategory.delete_all
    User.delete_all
    puts "✅ All old records deleted."

    puts "Resetting primary key sequences..."
    %w[
      users
      ingredient_categories
      ingredients
      cocktails
      cocktail_ingredients
      cocktail_likes
      cocktail_comments
      follow_requests
    ].each do |table_name|
      ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
    end
    puts "✅ ID sequences reset."

    puts "Importing users..."
    CSV.foreach(Rails.root.join("lib", "csvs", "users.csv"), headers: true) do |row|
      User.create!(
        username: row["username"],
        email: row["email"],
        bio: row["bio"],
        avatar_image: row["avatar_image"],
        password: row["password"],
        created_at: row["created_at"],
        updated_at: row["updated_at"]
      )
    end
    puts "Imported #{User.count} users."

    puts "Importing ingredient categories..."
    CSV.foreach(Rails.root.join("lib", "csvs", "ingredient_categories.csv"), headers: true) do |row|
      IngredientCategory.create!(
        name: row["name"],
        created_at: row["created_at"],
        updated_at: row["updated_at"]
      )
    end
    puts "Imported #{IngredientCategory.count} categories."

    puts "Importing ingredients..."
    CSV.foreach(Rails.root.join("lib", "csvs", "ingredients.csv"), headers: true) do |row|
      Ingredient.create!(
        name: row["name"],
        description: row["description"],
        abv: row["abv"],
        ingredient_category_id: row["ingredient_category_id"],
        created_at: row["created_at"],
        updated_at: row["updated_at"]
      )
    end
    puts "Imported #{Ingredient.count} ingredients."

    puts "Importing cocktails..."
    CSV.foreach(Rails.root.join("lib", "csvs", "cocktails.csv"), headers: true) do |row|
      Cocktail.create!(
        cocktail_name: row["cocktail_name"],
        description: row["description"],
        instructions: row["instructions"],
        abv: row["abv"],
        taste: row["taste"],
        image_url: row["image_url"],
        user_id: row["user_id"],
        created_at: row["created_at"],
        updated_at: row["updated_at"]
      )
    end
    puts "Imported #{Cocktail.count} cocktails."

    puts "Importing cocktail ingredients..."
    CSV.foreach(Rails.root.join("lib", "csvs", "cocktail_ingredients.csv"), headers: true) do |row|
      CocktailIngredient.create!(
        cocktail_id: row["cocktail_id"],
        ingredient_id: row["ingredient_id"],
        unit_ml: row["unit_ml"],
        created_at: row["created_at"],
        updated_at: row["updated_at"]
      )
    end
    puts "Imported #{CocktailIngredient.count} cocktail ingredients."

    puts "Importing cocktail likes..."
    CSV.foreach(Rails.root.join("lib", "csvs", "cocktail_likes.csv"), headers: true) do |row|
      CocktailLike.create!(
        user_id: row["user_id"],
        cocktail_id: row["cocktail_id"],
        created_at: row["created_at"],
        updated_at: row["updated_at"]
      )
    end
    puts "Imported #{CocktailLike.count} cocktail likes."

    puts "Importing cocktail comments..."
    CSV.foreach(Rails.root.join("lib", "csvs", "cocktail_comments.csv"), headers: true) do |row|
      CocktailComment.create!(
        user_id: row["user_id"],
        cocktail_id: row["cocktail_id"],
        comment_text: row["comment_text"],
        created_at: row["created_at"],
        updated_at: row["updated_at"]
      )
    end
    puts "Imported #{CocktailComment.count} cocktail comments."

    puts "Importing follow requests..."
    CSV.foreach(Rails.root.join("lib", "csvs", "follow_requests.csv"), headers: true) do |row|
      FollowRequest.create!(
        sender_id: row["sender_id"],
        recipient_id: row["recipient_id"],
        created_at: row["created_at"],
        updated_at: row["updated_at"]
      )
    end
    puts "Imported #{FollowRequest.count} follow requests."

    puts "✅ All CSV data imported successfully."
  end
end
