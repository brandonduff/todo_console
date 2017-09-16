require 'todo/task_list_fetcher'
require 'fileutils'
require_relative 'test_helper'

class TaskListFetcherTest < Minitest::Test
  def setup
    ENV['HOME'] = 'tmp'
    @current_day = Date.parse('10-03-1993')
    @current_day_file_name = 'tmp/current_day.txt'
    @todo_file_name = 'tmp/todos/10-03-1993.txt'
    current_day = File.open(@current_day_file_name, 'a')
    current_day.puts('10-03-1993')
    Dir.mkdir('tmp/todos') unless Dir.exist?('tmp/todos')
    todo_file = File.open(@todo_file_name, 'w+')
    todo_file.puts('hello')
    todo_file.close
    @multi_task_fetcher_double = Object.new
  end

  def teardown
    File.delete(@current_day_file_name)
    File.delete( @todo_file_name)
    FileUtils.remove_dir('tmp/todos')
  end

  def test_task_list_for_current_day
    fetcher = Todo::TaskListFetcher.new(@current_day)
    assert_equal(fetcher.task_data, "hello\n")
  end

  def test_task_list_for_current_day_is_empty_if_no_file_for_current_day
    fetcher = Todo::TaskListFetcher.new(Date.parse('7-4-1776'))
    assert_empty(fetcher.task_data)
  end

  def test_todo_file
    fetcher = Todo::TaskListFetcher.new(Date.parse('7-4-1776'))
    assert_equal('tmp/todos/07-04-1776.txt', fetcher.todo_file)
  end

  def test_for_week_returns_multi_task_list_fetcher_for_week
    week_range = Range.new(@current_day - 7, @current_day)
    allow(Todo::MultiTaskListFetcher).to receive(:new).with(week_range).and_return(@multi_task_fetcher_double)

    assert_equal(@multi_task_fetcher_double, Todo::TaskListFetcher.new(@current_day).for_week)
  end

  def test_for_month_returns_multi_task_list_fetcher_for_month
    month_range = Range.new(@current_day - 31, @current_day)
    allow(Todo::MultiTaskListFetcher).to receive(:new).with(month_range).and_return(@multi_task_fetcher_double)

    assert_equal(@multi_task_fetcher_double, Todo::TaskListFetcher.new(@current_day).for_month)
  end
end
