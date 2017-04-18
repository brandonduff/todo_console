require_relative 'test_helper'
require_relative '../src/todo_list'

class TodoListTest < Minitest::Test

  def setup
    @todo = TodoList.new
  end

  def test_adding_todo
    @todo.add_todo('hi')
    @todo.add_todo('guy')

    assert_equal(@todo.todos, ['hi', 'guy'])
  end

  def test_to_s_with_no_todos
    assert(@todo.to_s.empty?)
  end

  def test_to_s_with_one_todo
    @todo.add_todo('hi')

    assert_equal(@todo.to_s, 'hi')
  end

  def test_to_s_with_multiple_todos
    @todo.add_todo('hi')
    @todo.add_todo('guy')

    assert_equal(@todo.to_s, "hi\nguy")
  end

  def test_save_writes_todos_to_file
    buffer = StringIO.new
    @todo.add_todo("hi\n")

    @todo.save(buffer)
    assert_equal(@todo.to_s, buffer.string)
  end

  def test_initialize_from_existing_buffer
    initialBuffer = StringIO.new
    initialBuffer << "hi\ntry\nguy\n"
    resultBuffer = StringIO.new

    @todo = TodoList.new(initialBuffer)
    @todo.save(resultBuffer)
    assert_equal(initialBuffer.string, resultBuffer.string)
  end

  def test_shift_on_empty_todos_does_nothing
    @todo.done
    assert_equal(@todo.to_s, '')
  end

  def test_shift_on_one_todo_list_makes_todos_empty
    @todo.add_todo('hi')
    @todo.done
    assert_equal('', @todo.to_s)
  end

  def test_shift_with_two_todos_removes_the_first
    @todo.add_todo('hi')
    @todo.add_todo('guy')

    @todo.done

    assert_equal('guy', @todo.to_s)
  end
end
