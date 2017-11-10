module Todo
  module UseCases
    class Done

      def perform
        task_list = todays_task_list
        done_task = task_list.done
        write(task_list)
        present(done_task)
      end

      private

      def todays_task_list
        TaskListFetcher.new(reader).tasks_for_day(read_current_day)
      end

      def read_current_day
        reader.current_day
      end

      def write(task_list)
        Writer.for(task_list).write_to(env_helper.todo_file_for_day(reader.current_day))
      end

      def present(todo)
        todo.description
      end

      def reader
        Reader.new(env_helper)
      end

      def env_helper
        EnvHelper.new
      end
    end
  end
end
