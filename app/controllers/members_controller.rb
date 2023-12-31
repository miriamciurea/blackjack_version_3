class MembersController < ApplicationController

  # def new
  #   @member = Member.new
  #   redirect_to groups_path
  # end

  def create
    puts "Create action called"
    render plain: "Create action hit"
  end


  # def create
  #   member = Member.new(member_params)
  #   raise
  #   if member.save
  #     redirect_to groups_path, notice: 'Member was successfully added.'
  #   else
  #     redirect_to groups_path, alert: 'Failed to add member.'
  #   end
  # end

  private

  def member_params
    params.require(:member).permit(:user_id, :group_id)
  end

end
