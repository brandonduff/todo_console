require 'fileutils'
require 'test_helper'

class TaskListFetcherTest < Minitest::Test
  def setup
    @current_day = Date.parse('10-03-1993')
    @multi_task_fetcher_double = Object.new
    @reader = double
    allow(@reader).to receive(:task_data_for_day).with(@current_day).and_return(["hello"])
  end

  def test_task_list_for_current_day
    fetcher = Todo::TaskListFetcher.new(@reader)
    expected_task_list = Todo::TaskList.new
    expected_task_list.add_task(Todo::Task.new('hello', false))
    assert_equal(fetcher.tasks_for_day(@current_day), expected_task_list)
  end

  def test_for_week_returns_multi_task_list_fetcher_for_week
    week_range = Range.new(@current_day - 7, @current_day)
    allow(Todo::MultiTaskListFetcher).to receive(:new).with(week_range).and_return(@multi_task_fetcher_double)

    assert_equal(@multi_task_fetcher_double, Todo::TaskListFetcher.new(@reader).for_week(@current_day))
  end

  def test_for_month_returns_multi_task_list_fetcher_for_month
    month_range = Range.new(@current_day - 31, @current_day)
    allow(Todo::MultiTaskListFetcher).to receive(:new).with(month_range).and_return(@multi_task_fetcher_double)

    assert_equal(@multi_task_fetcher_double, Todo::TaskListFetcher.new(@reader).for_month(@current_day))
  end
end
