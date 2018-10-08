class Match

  attr_accessor :score_left, :balls_left, :player_ids, :current_player_ids, :current_strike_player_id, :next_player_ids, :scorecard

  def initialize(score_left, balls_left)
    @score_left = score_left
    @balls_left = balls_left
    @player_ids = Player.all.map(&:id)
    @current_player_ids = [@player_ids[0], @player_ids[1]]
    @current_strike_player_id = @player_ids[0]
    @next_player_ids = [@player_ids[3], @player_ids[2]]
    @scorecard = {}
    Player.all.map(&:name).each do |n|
      @scorecard[n] = {"balls_played": 0, "runs_scored": 0}
    end
  end

  def next_ball
    @balls_left -= 1
    ball_result = next_ball_result(@current_strike_player_id)
    current_player_name = Player.find(@current_strike_player_id).name
    @scorecard[current_player_name][:balls_played] += 1
    if ball_result == 7
      if @next_player_ids.empty?
        return "Chennai", ball_result
      else
        @current_player_ids.delete(@current_strike_player_id)
        @current_strike_player_id = @next_player_ids.pop
        @current_player_ids.push(@current_strike_player_id)
      end
    elsif [0, 2, 4, 6].include?(ball_result)
      @score_left -= ball_result
      @scorecard[current_player_name][:runs_scored] += ball_result
      return "Bengaluru", ball_result if @score_left <= 0
    elsif [1, 3, 5].include?(ball_result)
      @score_left -= ball_result
      @scorecard[current_player_name][:runs_scored] += ball_result
      @current_strike_player_id = (@current_player_ids - [@current_strike_player_id]).first
      return "Bengaluru", ball_result if @score_left <= 0
    end
    return "Chennai", ball_result if @balls_left == 0
    @current_strike_player_id = (@current_player_ids - [@current_strike_player_id]).first if @balls_left % 6 == 0
    return "Next", ball_result
  end

  def next_ball_result(player_id)
    Player.find(player_id).next_ball_result
  end
end
