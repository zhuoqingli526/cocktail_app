class AddCommentTextToCocktailComments < ActiveRecord::Migration[7.1]
  def change
    add_column :cocktail_comments, :comment_text, :text
  end
end
