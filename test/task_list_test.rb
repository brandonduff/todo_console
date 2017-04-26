require_relative 'test_helper'
require 'todo/task_list'

class TaskListTest < Minitest::Test

  def setup
    @task_list = Todo::TaskList.new
  end

  def test_adding_tasks
    @task_list.add_task('hi')
    @task_list.add_task('guy')

    assert_equal(@task_list.to_s, ['hi', 'guy'].join("\n"))
  end

  def test_to_s_with_no_tasks
    assert(@task_list.to_s.empty?)
  end

  def test_to_s_with_one_tasks
    @task_list.add_task('hi')

    assert_equal(@task_list.to_s, 'hi')
  end

  def test_to_s_with_multiple_tasks
    @task_list.add_task('hi')
    @task_list.add_task('guy')

    assert_equal(@task_list.to_s, "hi\nguy")
  end

  def test_save_writes_tasks_to_file
    buffer = StringIO.new
    @task_list.add_task("hi\n")

    @task_list.save(buffer)

    assert_equal(@task_list.to_s, buffer.string)
  end

  def test_initialize_from_existing_buffer
    initial_buffer = StringIO.new
    initial_buffer << "hi\ntry\nguy\n"
    result_buffer = StringIO.new

    @task_list = Todo::TaskList.new(initial_buffer)
    @task_list.save(result_buffer)

    assert_equal(initial_buffer.string, result_buffer.string)
  end

  def test_done_on_empty_list_does_nothing
    @task_list.done
    assert_equal(@task_list.to_s, '')
  end

  def test_done_on_one_task_marks_todo_as_done
    @task_list.add_task('hi')
    @task_list.done
    assert_equal('✓ hi', @task_list.to_s)
  end

  def test_done_on_list_with_done_tasks_marks_first_unfinished_task_as_done
    @task_list.add_task('i am already done')
    @task_list.done
    @task_list.add_task('i am now done')
    @task_list.done
    assert_equal("✓ i am already done\n✓ i am now done", @task_list.to_s)
  end
end
