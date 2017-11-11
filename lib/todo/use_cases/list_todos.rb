module Todo
  module UseCases
    class ListTodos
      def initialize(request)
        @request = request
      end

      def perform
        current_day = DayFormatter.format(persistence.read_current_day)
        tasks = task_fetcher.tasks_for_day(current_day)

        if @request[:all]
          present(tasks)
        else
          present(tasks.unfinished_tasks)
        end
      end

      private

      def present(tasks)
        tasks.to_a.map(&:description)
      end

      def persistence
        Persistence.new
      end

      def task_fetcher
        fetcher = TaskListFetcher.new(persistence)
        if @request[:month]
          fetcher.for_month
        elsif @request[:week]
          fetcher.for_week
        else
          fetcher
        end
      end
    end
  end
end
