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
        TaskListFetcher.new(Persistence.new).tasks_for_day(read_current_day)
      end

      def read_current_day
        reader.current_day
      end

      def write(task_list)
        Persistence.new.write_todays_tasks(task_list)
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
