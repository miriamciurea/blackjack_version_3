class GroupsController < ApplicationController

  def new
    @group = Group.new
    @users = User.all
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
