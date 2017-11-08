module Todo
  module UseCases
    class Done

      def perform
        task_list = TaskListFetcher.new(reader).tasks_for_day(read_current_day)
        done_task = task_list.done
        write(task_list)
        present(done_task)
      end

      private

      def read_current_day
        reader.current_day
      end

      def write(task_list)
        todo_file = File.open(env_helper.todo_file_for_day(reader.current_day), 'a')
        Writer.for(task_list).write_to(todo_file)
        todo_file.close
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
