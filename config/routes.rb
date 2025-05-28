Rails.application.routes.draw do
  devise_for :users


  root to: "home#index"

  # Routes for the Ingredient category resource:
  
  # CREATE
  post("/insert_ingredient_category", { :controller => "ingredient_categories", :action => "create" })
          
  # READ
  get("/ingredient_categories", { :controller => "ingredient_categories", :action => "index" })
  
  get("/ingredient_categories/:path_id", { :controller => "ingredient_categories", :action => "show" })
  
  # UPDATE
  
  post("/modify_ingredient_category/:path_id", { :controller => "ingredient_categories", :action => "update" })
  
  # DELETE
  get("/delete_ingredient_category/:path_id", { :controller => "ingredient_categories", :action => "destroy" })

  #------------------------------

  # Routes for the Ingredient resource:

  # CREATE
  post("/insert_ingredient", { :controller => "ingredients", :action => "create" })
          
  # READ
  get("/ingredients", { :controller => "ingredients", :action => "index" })
  
  get("/ingredients/:path_id", { :controller => "ingredients", :action => "show" })
  
  # UPDATE
  
  post("/modify_ingredient/:path_id", { :controller => "ingredients", :action => "update" })
  
  # DELETE
  get("/delete_ingredient/:path_id", { :controller => "ingredients", :action => "destroy" })

  #------------------------------

  # Routes for the Cocktail ingredient resource:

  # CREATE
  post("/insert_cocktail_ingredient", { :controller => "cocktail_ingredients", :action => "create" })
          
  # READ
  get("/cocktail_ingredients", { :controller => "cocktail_ingredients", :action => "index" })
  
  get("/cocktail_ingredients/:path_id", { :controller => "cocktail_ingredients", :action => "show" })
  
  # UPDATE
  
  post("/modify_cocktail_ingredient/:path_id", { :controller => "cocktail_ingredients", :action => "update" })
  
  # DELETE
  get("/delete_cocktail_ingredient/:path_id", { :controller => "cocktail_ingredients", :action => "destroy" })

  #------------------------------

  # Routes for the Follow request resource:

  # CREATE
  post("/insert_follow_request", { :controller => "follow_requests", :action => "create" })
          
  # READ
  get("/follow_requests", { :controller => "follow_requests", :action => "index" })
  
  get("/follow_requests/:path_id", { :controller => "follow_requests", :action => "show" })
  
  # DELETE
  delete "/follow_requests/:path_id", { :controller => "follow_requests", :action => "destroy" }  


  #------------------------------

  # Routes for the Cocktail like resource:

  # CREATE
  post("/insert_cocktail_like", { :controller => "cocktail_likes", :action => "create" })
          
  # READ
  get("/cocktail_likes", { :controller => "cocktail_likes", :action => "index" })
  
  get("/cocktail_likes/:path_id", { :controller => "cocktail_likes", :action => "show" })
  
  # UPDATE
  
  post("/modify_cocktail_like/:path_id", { :controller => "cocktail_likes", :action => "update" })
  
  # DELETE
  get("/delete_cocktail_like/:path_id", { :controller => "cocktail_likes", :action => "destroy" })

  #------------------------------

  # Routes for the Cocktail comment resource:

  # CREATE
  post("/insert_cocktail_comment", { :controller => "cocktail_comments", :action => "create" })
          
  # READ
  get("/cocktail_comments", { :controller => "cocktail_comments", :action => "index" })
  
  get("/cocktail_comments/:path_id", { :controller => "cocktail_comments", :action => "show" })
  
  # UPDATE
  
  post("/modify_cocktail_comment/:path_id", { :controller => "cocktail_comments", :action => "update" })
  
  # DELETE
  get("/delete_cocktail_comment/:path_id", { :controller => "cocktail_comments", :action => "destroy" })

  #------------------------------

  # Routes for the Cocktail resource:

  # CREATE
  post("/insert_cocktail", { :controller => "cocktails", :action => "create" })
          
  # READ
  get("/cocktails", { :controller => "cocktails", :action => "index" })
  
  get("/cocktails/:path_id", { :controller => "cocktails", :action => "show" })
  
  # UPDATE
  
  post("/modify_cocktail/:path_id", { :controller => "cocktails", :action => "update" })
  
  # DELETE
  get("/delete_cocktail/:path_id", { :controller => "cocktails", :action => "destroy" })

  #------------------------------

  # Routes for the User resource:


  get("/users/:username/liked_cocktails", { :controller => "users", :action => "liked_cocktails" })
  get("/users/:username/feed", { :controller => "users", :action => "feed" })
  get("/users/:username/popular_picks", { :controller => "users", :action => "popular_picks" })
  
  # CREATE
  post("/insert_user", { :controller => "users", :action => "create" })
          
  # READ
  get("/users", { :controller => "users", :action => "index" })
  
  get("/users/:path_id", { :controller => "users", :action => "show" })
  
  # UPDATE
  
  post("/modify_user/:path_id", { :controller => "users", :action => "update" })
  
  # DELETE
  get("/delete_user/:path_id", { :controller => "users", :action => "destroy" })


  
end
