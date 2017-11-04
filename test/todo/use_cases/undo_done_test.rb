require_relative 'base'

module Todo
  module UseCases
    class UndoDoneTest < Base
      def test_undo_returns_undone_todo
        skip
        build_todo_file(todo_file_for('10-03-1993'))
        task_list = build_task_list([{ description: 'hello' }, { description: 'goodbye' }])
        save_todo_file(task_list)
        assert_equal('goodbye', UndoDone.new.perform)
      end

      private


      def build_task_list(task_args)
        TaskList.new.tap do |task_list|
          task_args.each do |task_arg|
            task_list.add_task(Task.new(task_arg[:description], task_arg[:done]))
          end
        end
      end
    end
  end
end
