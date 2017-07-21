require_relative 'test_helper'
require 'todo/task'

class TaskTest < Minitest::Test
  def setup
    @task_item = Todo::Task.new('do this and that')
  end

  def test_initialized_as_done
    task_item = Todo::Task.new('do this and that', true)
    assert(task_item.done?)
  end

  def test_description
    assert_equal('do this and that', @task_item.description)
  end

  def test_done
    done_task = @task_item.done
    assert_equal('✓ do this and that', done_task.description)
  end

  def test_done?
    assert(!@task_item.done?)
    done_task = @task_item.done
    assert(done_task.done?)
  end

  def test_in_progress?
    assert(@task_item.in_progress?)
    done_task = @task_item.done
    assert(!done_task.in_progress?)
  end

  def test_undo_with_one_done_task_undoes_it
    @task_item.done
    undone_task = @task_item.undo
    assert_equal('do this and that', undone_task.description)
  end

  def test_equality_is_true_when_description_and_doneness_are_eqaul
    other_task = Todo::Task.new(@task_item.description)
    assert_equal(other_task, @task_item)

    other_task = Todo::Task.new(@task_item.description, true)
    assert(other_task != @task_item)

    other_task = Todo::Task.new('different description')
    assert(other_task != @task_item)
  end
end

