require 'test_helper'
require 'fileutils'

module Todo
  module UseCases
    class CreateTodoTest < Minitest::Test

      def setup
        setup_file_system
      end

      def teardown
        reset_home
      end

      def test_create_todo
        CreateTodo.new('test').perform

        assert_equal("test\n", File.read(todo_file_for(@today)))
      end

      def test_does_not_override_existing_todos
        existing_list = TaskList.new
        existing_list.add_task(Task.new('existing', false))
        todo_buffer = File.open(todo_file_for(@today), 'a')
        Writer.for(existing_list).write_to(todo_buffer)
        todo_buffer.close

        CreateTodo.new('test').perform

        assert_equal("existing\ntest\n", File.read(todo_file_for(@today)))
      end

      private

      def setup_file_system
        @original_home = ENV['HOME']
        ENV['HOME'] = 'tmp'
        @today = '10-03-1993'
        FileUtils.rm_rf('tmp')
        current_day = Date.parse(@today)
        current_day_file_name = 'tmp/.current_day.txt'
        Dir.mkdir('tmp') unless Dir.exist?('tmp')
        current_day = File.open(current_day_file_name, 'a')
        current_day.puts(@today)
        current_day.close
        Dir.mkdir('tmp/todos')
      end

      def reset_home
        ENV['HOME'] = @original_home
      end

      def todo_file_for(day)
        "tmp/todos/#{day}.txt"
      end
    end
  end
end
