class UsersController < ApplicationController
  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :created_at => :desc })

    render({ :template => "users/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_users = User.where({ :id => the_id })

    @the_user = matching_users.at(0)

    render({ :template => "users/show" })
  end

  def create
    the_user = User.new
    the_user.username = params.fetch("query_username")
    the_user.bio = params.fetch("query_bio")
    the_user.avatar_image = params.fetch("query_avatar_image")
    the_user.email = params.fetch("query_email")
    the_user.password = params.fetch("query_password")

    if the_user.valid?
      the_user.save
      redirect_to("/users", { :notice => "User created successfully." })
    else
      redirect_to("/users", { :alert => the_user.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_user = User.where({ :id => the_id }).at(0)

    the_user.username = params.fetch("query_username")
    the_user.bio = params.fetch("query_bio")
    the_user.avatar_image = params.fetch("query_avatar_image")
    the_user.email = params.fetch("query_email")
    the_user.password = params.fetch("query_password")

    if the_user.valid?
      the_user.save
      redirect_to("/users/#{the_user.id}", { :notice => "User updated successfully."} )
    else
      redirect_to("/users/#{the_user.id}", { :alert => the_user.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_user = User.where({ :id => the_id }).at(0)

    the_user.destroy

    redirect_to("/users", { :notice => "User deleted successfully."} )
  end

  def liked_cocktails
    @the_user = User.find_by(username: params[:username])
    @cocktails = @the_user.liked_cocktails

    render({ template: "users/liked_cocktails" })
  end


  def feed
    @the_user = User.find_by(username: params[:username])
    leader_ids  = @the_user.leaders.pluck(:id)
    @the_leader_cocktails = Cocktail.where({ user_id: leader_ids })
                              .order({ created_at: :desc })

    render({ template: "users/feed" })
  end

  def popular_picks
    @the_user = User.find_by(username: params[:username])
    excluded_user_ids = @the_user.leaders.pluck(:id) + [@the_user.id]

    all_other_cocktails = Cocktail.where.not(user_id: excluded_user_ids)
    @popular_cocktails = all_other_cocktails.sort_by { |cocktail| -cocktail.likes.count }
    render({ template: "users/popular_picks" })

  end
end
