# lib/tasks/slurp.rake

require "csv"

namespace :slurp do
  desc "Import all CSV data into the database"
  task all: :environment do

    puts "Importing users..."
    CSV.foreach(Rails.root.join("lib", "csvs", "users.csv"), headers: true) do |row|
      User.create!(
        username: row["username"],
        email: row["email"],
        bio: row["bio"],
        avatar_url: row["avatar_url"]
      )
    end
    puts "Imported #{User.count} users."

    puts "Importing ingredient categories..."
    CSV.foreach(Rails.root.join("lib", "csvs", "ingredient_categories.csv"), headers: true) do |row|
      IngredientCategory.create!(
        name: row["name"]
      )
    end
    puts "Imported #{IngredientCategory.count} categories."

    puts "Importing ingredients..."
    CSV.foreach(Rails.root.join("lib", "csvs", "ingredients.csv"), headers: true) do |row|
      Ingredient.create!(
        name: row["name"],
        unit_ml: row["unit_ml"],
        category_id: row["category_id"]
      )
    end
    puts "Imported #{Ingredient.count} ingredients."

    puts "Importing cocktails..."
    CSV.foreach(Rails.root.join("lib", "csvs", "cocktails.csv"), headers: true) do |row|
      Cocktail.create!(
        name: row["name"],
        description: row["description"],
        instructions: row["instructions"],
        taste: row["taste"],
        user_id: row["user_id"],
        image_url: row["image_url"],
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
        amount_ml: row["amount_ml"]
      )
    end
    puts "Imported #{CocktailIngredient.count} cocktail ingredients."

    puts "Importing cocktail likes..."
    CSV.foreach(Rails.root.join("lib", "csvs", "cocktail_likes.csv"), headers: true) do |row|
      CocktailLike.create!(
        user_id: row["user_id"],
        cocktail_id: row["cocktail_id"]
      )
    end
    puts "Imported #{CocktailLike.count} cocktail likes."

    puts "Importing cocktail comments..."
    CSV.foreach(Rails.root.join("lib", "csvs", "cocktail_comments.csv"), headers: true) do |row|
      CocktailComment.create!(
        user_id: row["user_id"],
        cocktail_id: row["cocktail_id"],
        content: row["content"]
      )
    end
    puts "Imported #{CocktailComment.count} cocktail comments."

    puts "Importing follow requests..."
    CSV.foreach(Rails.root.join("lib", "csvs", "follow_requests.csv"), headers: true) do |row|
      FollowRequest.create!(
        sender_id: row["sender_id"],
        recipient_id: row["recipient_id"],
        status: row["status"]
      )
    end
    puts "Imported #{FollowRequest.count} follow requests."

    puts "✅ All CSV data imported successfully."
  end
end
