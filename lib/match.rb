class Match

  attr_accessor :score_left, :balls_left, :player_ids, :current_player_ids, :current_strike_player_id, :next_player_ids, :scorecard

  def initialize(score_left, balls_left)
    # Initializing all variables required for a match
    @score_left = score_left
    @balls_left = balls_left
    @player_ids = Player.all.map(&:id)
    @current_player_ids = [@player_ids[0], @player_ids[1]]
    @current_strike_player_id = @player_ids[0]
    @next_player_ids = [@player_ids[3], @player_ids[2]]
    @scorecard = {}
    Player.all.each do |n|
      @scorecard[n.name] = {"balls_played": 0, "runs_scored": 0, "id": n.id}
    end
  end

  # This is where the magic happens
  # This is the match simulation logic. All rules are taken care of here
  # Calling this function returns Next if no team won yet, Bengaluru if Bengaluru won and Chennai if Chennai won
  def next_ball
    @balls_left -= 1
    ball_result = next_ball_result(@current_strike_player_id)
    current_player_name = Player.find(@current_strike_player_id).name
    @scorecard[current_player_name][:balls_played] += 1
    if ball_result == 7
      # Player got out
      if @next_player_ids.empty?
        # Match Over
        @current_player_ids.delete(@current_strike_player_id)
        return "Chennai", ball_result
      else
        # Get next player to strike
        @current_player_ids.delete(@current_strike_player_id)
        @current_strike_player_id = @next_player_ids.pop
        @current_player_ids.push(@current_strike_player_id)
      end
    elsif [0, 2, 4, 6].include?(ball_result)
      # Player scored even runs. No strike change
      @score_left -= ball_result
      @scorecard[current_player_name][:runs_scored] += ball_result
      return "Bengaluru", ball_result if @score_left <= 0
    elsif [1, 3, 5].include?(ball_result)
      # Player Scored Odd runs. Strike will change
      @score_left -= ball_result
      @scorecard[current_player_name][:runs_scored] += ball_result

      # Strike change as odd runs
      @current_strike_player_id = (@current_player_ids - [@current_strike_player_id]).first

      return "Bengaluru", ball_result if @score_left <= 0 # Match Over
    end
    return "Chennai", ball_result if @balls_left == 0 # Match Over

    # If next over, Change strike
    @current_strike_player_id = (@current_player_ids - [@current_strike_player_id]).first if @balls_left % 6 == 0

    return "Next", ball_result # Match Continued
  end

  def next_ball_result(player_id)
    # Predicts next ball outcome for given player
    Player.find(player_id).next_ball_result
  end
end
