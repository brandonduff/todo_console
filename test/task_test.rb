require_relative 'test_helper'
require 'todo/task'

class TaskTest < Minitest::Test

  def setup
    @task = Todo::Task.new
  end

  def test_adding_todo
    @task.add_todo('hi')
    @task.add_todo('guy')

    assert_equal(@task.to_s, ['hi', 'guy'].join("\n"))
  end

  def test_to_s_with_no_todos
    assert(@task.to_s.empty?)
  end

  def test_to_s_with_one_todo
    @task.add_todo('hi')

    assert_equal(@task.to_s, 'hi')
  end

  def test_to_s_with_multiple_todos
    @task.add_todo('hi')
    @task.add_todo('guy')

    assert_equal(@task.to_s, "hi\nguy")
  end

  def test_save_writes_todos_to_file
    buffer = StringIO.new
    @task.add_todo("hi\n")

    @task.save(buffer)

    assert_equal(@task.to_s, buffer.string)
  end

  def test_initialize_from_existing_buffer
    initial_buffer = StringIO.new
    initial_buffer << "hi\ntry\nguy\n"
    result_buffer = StringIO.new

    @task = Todo::Task.new(initial_buffer)
    @task.save(result_buffer)

    assert_equal(initial_buffer.string, result_buffer.string)
  end

  def test_done_on_empty_todos_does_nothing
    @task.done
    assert_equal(@task.to_s, '')
  end

  def test_done_on_one_task_marks_todo_as_done
    @task.add_todo('hi')
    @task.done
    assert_equal('✓ hi', @task.to_s)
  end

  def test_done_on_task_with_done_todos_marks_first_unfinished_todo_as_done
    @task.add_todo('i am already done')
    @task.done
    @task.add_todo('i am now done')
    @task.done
    assert_equal("✓ i am already done\n✓ i am now done", @task.to_s)
  end
end
