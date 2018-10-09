class Player < ApplicationRecord
  
    default_scope { order(created_at: :asc) }
    validates :zero_prob, :one_prob, :two_prob, :three_prob, :four_prob, :five_prob, :six_prob, :out_prob, presence: true, numericality: { only_integer: true }
    validate :sum_equals_100

    # Calling this function on a player instance returns a number between 0..7
    # 0..6 represent the runs scored. 7 represents OUT.
    # This is the weighted random number generation as per probabilities as asked in the question.
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
    
    # Getting the sum of weights for weighted random number generation
    def sum_of_weights(weighted)
      weighted.inject(0) { |sum, (item, weight)| sum + weight }
    end

    def sum_equals_100
       if zero_prob + one_prob + two_prob + three_prob + four_prob + five_prob + six_prob + out_prob != 100
         errors.add(:base, 'Probabilities must sum to 100')
       end
    end
end
