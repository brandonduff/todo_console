require_relative 'test_helper'
require 'todo/day'

class DayTest < MiniTest::Test
  def test_day_returns_day_from_passed_buffer
    date = '10/03/1993'
    assert_equal(date, Todo::Day.new(date).to_s)
  end
end