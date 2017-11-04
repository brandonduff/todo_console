module Todo
  module UseCases
    class UndoDone

      def perform
        TaskListFetcher.new(Date.parse(read_current_day)).undo
      end

      def read_current_day
        Reader.new(EnvHelper.new).current_day
      end

    end
  end
end
