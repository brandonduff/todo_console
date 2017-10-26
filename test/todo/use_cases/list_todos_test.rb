require 'test_helper'
require 'fileutils'

module Todo
  module UseCases
    class ListTodosTest < Minitest::Test

      def setup
        @original_home = ENV['HOME']
        ENV['HOME'] = 'tmp'
        @today = '10-03-1993'
        current_day = Date.parse(@today)
        current_day_file_name = 'tmp/.current_day.txt'
        Dir.mkdir('tmp') unless Dir.exist?('tmp')
        current_day = File.open(current_day_file_name, 'a')
        current_day.puts(@today)
        current_day.close
        Dir.mkdir('tmp/todos') unless Dir.exist?('tmp/todos')
        build_todo_file(todo_file_for(@today))
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
        task_list = build_task_list([{ description: 'hello' }, { description: 'goodbye' }])
        save_todo_file(task_list)

        todos = ListTodos.new({}).perform

        assert_equal(%w(hello goodbye), todos)
      end

      def test_all_options_returns_unfinished_tasks
        task_list = build_task_list([{ description: 'hello' }])
        done_todo = Task.new('done', true)
        task_list.add_task(done_todo)
        save_todo_file(task_list)

        todos = ListTodos.new(all: true).perform

        assert_equal([task_list.to_a[0].description, done_todo.description], todos)
      end

      def test_week_option
        second_task_list = build_task_list([description: 'world'])
        save_todo_file(second_task_list)
        yesterday = '09-03-1993'
        build_todo_file(todo_file_for(yesterday))
        first_task_list = build_task_list([description: 'hello'])
        save_todo_file(first_task_list)

        todos = ListTodos.new(week: true).perform

        assert_equal([first_task_list.to_a.first.description, second_task_list.to_a.first.description], todos)
      end

      def test_month_option
        last_week = '01-03-1993'
        second_task_list = build_task_list([description: 'world'])
        save_todo_file(second_task_list)
        build_todo_file(todo_file_for(last_week))
        first_task_list = build_task_list([description: 'hello'])
        save_todo_file(first_task_list)

        todos = ListTodos.new(month: true).perform

        assert_equal([first_task_list.to_a.first.description, second_task_list.to_a.first.description], todos)
      end

      private

      def build_task_list(task_args)
        TaskList.new.tap do |task_list|
          task_args.each do |task_arg|
            task_list.add_task(Task.new(task_arg[:description], task_arg[:done]))
          end
        end
      end

      def build_todo_file(todo_file_name = 'tmp/todos/10-03-1993.txt')
        @todo_file = File.open(todo_file_name, 'w+')
      end

      def save_todo_file(task_list)
        Writer.for(task_list).write_to(@todo_file)
        @todo_file.close
      end

      def todo_file_for(day)
        "tmp/todos/#{day}.txt"
      end
    end
  end
end
