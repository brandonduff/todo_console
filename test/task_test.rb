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
    initialBuffer = StringIO.new
    initialBuffer << "hi\ntry\nguy\n"
    resultBuffer = StringIO.new

    @task = Todo::Task.new(initialBuffer)
    @task.save(resultBuffer)
    assert_equal(initialBuffer.string, resultBuffer.string)
  end

  def test_shift_on_empty_todos_does_nothing
    @task.done
    assert_equal(@task.to_s, '')
  end

  def test_shift_on_one_todo_list_makes_todos_empty
    @task.add_todo('hi')
    @task.done
    assert_equal('', @task.to_s)
  end

  def test_shift_with_two_todos_removes_the_first
    @task.add_todo('hi')
    @task.add_todo('guy')

    @task.done

    assert_equal('guy', @task.to_s)
  end
end
