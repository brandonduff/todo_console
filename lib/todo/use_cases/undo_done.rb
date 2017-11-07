module Todo
  module UseCases
    class UndoDone

      def perform
        present(TaskListFetcher.new(reader).tasks_for_day(read_current_day).done)
      end

      def read_current_day
        reader.current_day
      end

      private

      def present(todo)
        todo.description
      end
      def reader
        Reader.new(EnvHelper.new)
      end
    end
  end
end
