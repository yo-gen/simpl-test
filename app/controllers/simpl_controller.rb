class SimplController < ApplicationController
  def front_page
  end

  def sim_match
    @commentary = []
    @m = Match.new(40, 24)
    result = nil
    loop do
      @commentary << "#{(@m.balls_left / 6)} overs left. #{@m.score_left} runs to win." if @m.balls_left % 6 == 0
      current_player_name = Player.find(@m.current_strike_player_id).name
      next_ball = @m.next_ball
      next_comment = next_ball[1] == 7 ? "got Out" : "scored #{next_ball[1]} runs"
      @commentary << "#{current_player_name} #{next_comment}"
      if next_ball[0] != "Next"
        result = next_ball[0]
        break
      end
    end
    if result == "Bengaluru"
      @result = "Bengaluru won by #{@m.next_player_ids.count + 1} wickets and #{@m.balls_left} balls remaining."
    elsif result == "Chennai"
      @result = "Chennai won by #{@m.score_left} runs."
    end
  end
end
