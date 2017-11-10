require_relative 'base'

module Todo
  module UseCases
    class ListTodosTest < Base

      def setup
        super
        build_todo_file(todo_file_for('10-03-1993'))
      end

      def test_list_with_no_current_todos_returns_empty_list
        todos = ListTodos.new({}).perform

        assert_equal([], todos)
      end

      def test_list_returns_todos_as_array
        task_list = TaskListBuilder.new([{ description: 'hello' }, { description: 'goodbye' }]).build
        save_todo_file(task_list)

        todos = ListTodos.new({}).perform

        assert_equal(%w(hello goodbye), todos)
      end

      def test_all_options_returns_unfinished_tasks
        task_list = TaskListBuilder.new([{ description: 'hello' }]).build
        done_todo = Task.new('done', true)
        task_list.add_task(done_todo)
        save_todo_file(task_list)

        todos = ListTodos.new(all: true).perform

        assert_equal([task_list.to_a[0].description, done_todo.description], todos)
      end

      def test_week_option
        second_task_list = TaskListBuilder.new([description: 'world']).build
        save_todo_file(second_task_list)
        yesterday = '09-03-1993'
        build_todo_file(todo_file_for(yesterday))
        first_task_list = TaskListBuilder.new([description: 'hello']).build
        save_todo_file(first_task_list)

        todos = ListTodos.new(week: true).perform

        assert_equal([first_task_list.to_a.first.description, second_task_list.to_a.first.description], todos)
      end

      def test_month_option
        last_week = '01-03-1993'
        second_task_list = TaskListBuilder.new([description: 'world']).build
        save_todo_file(second_task_list)
        build_todo_file(todo_file_for(last_week))
        first_task_list = TaskListBuilder.new([description: 'hello']).build
        save_todo_file(first_task_list)

        todos = ListTodos.new(month: true).perform

        assert_equal([first_task_list.to_a.first.description, second_task_list.to_a.first.description], todos)
      end
    end
  end
end
