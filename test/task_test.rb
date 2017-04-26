require_relative 'test_helper'
require 'todo/task'

class TaskTest < Minitest::Test
  def setup
    @task_item = Todo::Task.new('do this and that')
  end

  def test_initialized_as_done
    task_item = Todo::Task.new('✓ do this and that')
    assert(task_item.done?)
  end

  def test_description
    assert_equal('do this and that', @task_item.description)
  end

  def test_done
    @task_item.done
    assert_equal('✓ do this and that', @task_item.description)
  end

  def test_done?
    assert(!@task_item.done?)
    @task_item.done
    assert(@task_item.done?)
  end

  def test_in_progress?
    assert(@task_item.in_progress?)
    @task_item.done
    assert(!@task_item.in_progress?)
  end
end

