class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def show
    @user = current_user
    memberships = Member.where("user_id = ?", current_user.id)
    @groups_part_of = []
    memberships.each do |m|
      @groups_part_of << Group.find_by("id = ?", m.group_id)
    end
    @admin_groups = Group.where("user_id = ?", current_user.id)
  end

  def index
    @users = User.all
    @groups = Group.all
  end

  def new
  end

  def create
  end

  def search
    @users = User.where('nickname LIKE ?', "%#{params[:query]}%")
    render json: @users
  end

end
