require 'todo/day_formatter'
require 'date'
require_relative 'test_helper'

class DayFormatterTest < Minitest::Test
  def setup
    allow(Date).to receive(:today).and_return(Date.parse("10-03-1993"))
  end

  def test_format_with_date_string_returns_date_string
    assert_equal("10-03-1993", Todo::DayFormatter.format("10-03-1993"))
  end

  def test_format_with_today_returns_current_date
    assert_equal("10-03-1993", Todo::DayFormatter.format("today"))
  end

  def test_format_with_empty_string_returns_current_date
    assert_equal("10-03-1993", Todo::DayFormatter.format(""))
  end
end
