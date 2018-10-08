class Player < ApplicationRecord
    def next_ball_result
      mapping = {"zero_prob": 0, "one_prob": 1, "two_prob": 2, "three_prob": 3, "four_prob": 4, "five_prob": 5, "six_prob": 6, "out_prob": 7}
      weighted = self.attributes.slice("zero_prob", "one_prob", "two_prob", "three_prob", "four_prob", "five_prob", "six_prob", "out_prob")
      max    = sum_of_weights(weighted)
      target = rand(1..max)
      weighted.each do |item, weight|
        return mapping[item.to_sym] if target <= weight
        target -= weight
      end
    end
    
    def sum_of_weights(weighted)
      weighted.inject(0) { |sum, (item, weight)| sum + weight }
    end
end
