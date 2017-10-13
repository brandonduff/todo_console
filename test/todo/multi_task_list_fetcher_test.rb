require 'test_helper'
require 'date'
require 'todo/task_list_fetcher'

class MultiTaskListFetcherTest < Minitest::Test

  def test_task_data_for_one_day_range
    first_day = Date.parse('10-03-1993')
    second_day = first_day
    date_range = Range.new(first_day, second_day)
    fetcher = instance_double("TaskListFetcher")

    allow(Todo::TaskListFetcher).to receive(:new).with(date_range).and_return(fetcher)
    allow(fetcher).to receive(:task_data).and_return('data')

    assert_equal('data', Todo::MultiTaskListFetcher.new(date_range).task_data)
  end

  def test_task_data_for_range
    first_day = Date.parse('10-03-1993')
    second_day = Date.parse('12-03-1993')
    date_range = Range.new(first_day, second_day)
    first_fetcher = instance_double("TaskListFetcher")
    second_fetcher = instance_double("TaskListFetcher")
    third_fetcher = instance_double("TaskListFetcher")

    allow(Todo::TaskListFetcher).to receive(:new).with(date_range.first).and_return(first_fetcher)
    allow(Todo::TaskListFetcher).to receive(:new).with(Date.parse('11-03-1993')).and_return(second_fetcher)
    allow(Todo::TaskListFetcher).to receive(:new).with(date_range.last).and_return(third_fetcher)
    allow(first_fetcher).to receive(:task_data).and_return('first ')
    allow(second_fetcher).to receive(:task_data).and_return('second ')
    allow(third_fetcher).to receive(:task_data).and_return('third')


    assert_equal('first second third', Todo::MultiTaskListFetcher.new(date_range).task_data)
  end
end
