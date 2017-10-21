require 'test_helper'

module Todo
  module UseCases
    class ListTodosTest < Minitest::Test

      def setup
        ENV['HOME'] = 'tmp'
        current_day = Date.parse('10-03-1993')
        current_day_file_name = 'tmp/current_day.txt'
        @todo_file_name = 'tmp/todos/10-03-1993.txt'
        Dir.mkdir('tmp') unless Dir.exist?('tmp')
        current_day = File.open(current_day_file_name, 'a')
        current_day.puts('10-03-1993')
        Dir.mkdir('tmp/todos') unless Dir.exist?('tmp/todos')
      end

      def test_list_with_no_current_todos_returns_empty_list
        todos = ListTodos.new({}).perform

        assert_equal([], todos)
      end

      def test_list_with_one_todo_returns_the_todo
        todo_file = File.open(@todo_file_name, 'w+')
        todo_file.puts('hello')
        todo_file.close

      end
    end
  end
end
