class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :zero_prob
      t.integer :one_prob
      t.integer :two_prob
      t.integer :three_prob
      t.integer :four_prob
      t.integer :five_prob
      t.integer :six_prob
      t.integer :out_prob

      t.timestamps
    end
  end
end
