require 'test_helper'
require 'fileutils'

module Todo
  module UseCases
    class ListTodosTest < Minitest::Test

      def setup
        @original_home = ENV['HOME']
        ENV['HOME'] = 'tmp'
        current_day = Date.parse('10-03-1993')
        current_day_file_name = 'tmp/.current_day.txt'
        Dir.mkdir('tmp') unless Dir.exist?('tmp')
        current_day = File.open(current_day_file_name, 'a')
        current_day.puts('10-03-1993')
        current_day.close
        Dir.mkdir('tmp/todos') unless Dir.exist?('tmp/todos')
      end

      def teardown
        ENV['HOME'] = @original_home
        FileUtils.rm_rf('tmp')
      end

      def test_list_with_no_current_todos_returns_empty_list
        todos = ListTodos.new({}).perform

        assert_equal([], todos)
      end

      def test_list_returns_todos_as_array
        build_todo_file
        save_todo_file

        todos = ListTodos.new({}).perform

        assert_equal(%w(hello goodbye), todos)
      end

      def test_all_options_returns_unfinished_tasks
        build_todo_file
        done_todo = Task.new('done', true)
        @task_list.add_task(done_todo)
        save_todo_file

        todos = ListTodos.new(all: true).perform

        assert_equal([@todo1.description, @todo2.description, done_todo.description], todos)
      end

      private

      def build_todo_file
        todo_file_name = 'tmp/todos/10-03-1993.txt'
        @todo_file = File.open(todo_file_name, 'w+')
        @task_list = TaskList.new
        @todo1 = Task.new('hello', false)
        @task_list.add_task(@todo1)
        @todo2 = Task.new('goodbye', false)
        @task_list.add_task(@todo2)
      end

      def save_todo_file
        Writer.for(@task_list).write_to(@todo_file)
        @todo_file.close
      end
    end
  end
end
