class GamesController < ApplicationController

  def solo_game
    @score = current_user.score
  end

  def update_score
    # Retrieve the user and update the score
    current_user.update(score: params[:new_points])

    render json: { status: "success" }
  end

end
