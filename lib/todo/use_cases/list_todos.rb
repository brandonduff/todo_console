module Todo
  module UseCases
    class ListTodos
      def initialize(request)
        @request = request
      end

      def perform
        current_day = DayFormatter.format(read_current_day)
        tasks = task_fetcher(current_day).tasks_for_day(current_day)

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

      def read_current_day
        Reader.new(EnvHelper.new).current_day
      end

      def task_fetcher(current_day)
        fetcher = TaskListFetcher.new(Reader.new(EnvHelper.new))
        if @request[:month]
          fetcher.for_month(Date.parse(current_day))
        elsif @request[:week]
          fetcher.for_week(Date.parse(current_day))
        else
          fetcher
        end
      end
    end
  end
end
