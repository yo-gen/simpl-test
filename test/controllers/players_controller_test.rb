require 'test_helper'

class PlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player = players(:one)
  end

  test "should get index" do
    get players_url
    assert_response :success
  end

  test "should get new" do
    get new_player_url
    assert_response :success
  end

  test "should create player" do
    assert_difference('Player.count') do
      post players_url, params: { player: { five_prob: @player.five_prob, four_prob: @player.four_prob, name: @player.name, one_prob: @player.one_prob, out_prob: @player.out_prob, six_prob: @player.six_prob, three_prob: @player.three_prob, two_prob: @player.two_prob, zero_prob: @player.zero_prob } }
    end

    assert_redirected_to player_url(Player.last)
  end

  test "should show player" do
    get player_url(@player)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_url(@player)
    assert_response :success
  end

  test "should update player" do
    patch player_url(@player), params: { player: { five_prob: @player.five_prob, four_prob: @player.four_prob, name: @player.name, one_prob: @player.one_prob, out_prob: @player.out_prob, six_prob: @player.six_prob, three_prob: @player.three_prob, two_prob: @player.two_prob, zero_prob: @player.zero_prob } }
    assert_redirected_to player_url(@player)
  end

  test "should destroy player" do
    assert_difference('Player.count', -1) do
      delete player_url(@player)
    end

    assert_redirected_to players_url
  end
end
