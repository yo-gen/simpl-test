# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
player1 = Player.create([{name: 'Kirat Boli', zero_prob: 5, one_prob: 30, two_prob: 25, three_prob: 10, four_prob: 15, five_prob: 1, six_prob: 9, out_prob: 5}])
player2 = Player.create([{name: 'N.S Nodhi', zero_prob: 10, one_prob: 40, two_prob: 20, three_prob: 5, four_prob: 10, five_prob: 1, six_prob: 4, out_prob: 10}])
player3 = Player.create([{name: 'R Rumrah', zero_prob: 20, one_prob: 30, two_prob: 15, three_prob: 5, four_prob: 5, five_prob: 1, six_prob: 4, out_prob: 20}])
player4 = Player.create([{name: 'Shashi Henra', zero_prob: 30, one_prob: 25, two_prob: 5, three_prob: 0, four_prob: 5, five_prob: 1, six_prob: 4, out_prob: 30}])
