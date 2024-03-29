class GroupsController < ApplicationController

  def new
    @group = Group.new
    @users = User.all
  end

  def index
    @groups = Group.all
  end

  def create
    @group = Group.find(params[:group_id])
    @member = Member.new
    @card.brand = @brand
    @card.user = current_user
    @card.save
    # redirect_to brands_path, notice: "card created successfully!"
    head :ok
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def group_params
    params.require(:group).permit(:id, :name, :max_members, user_ids: [])
  end

end
