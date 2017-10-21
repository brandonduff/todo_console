module Todo
  module UseCases
    class ListTodos
      def initialize(request)
        @request = request
      end

      def perform
        current_day = DayFormatter.format(read_current_day)
        initial_buffer = task_fetcher(current_day).task_data
        tasks = TaskList.new(StringIO.new(initial_buffer))

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
        fetcher = TaskListFetcher.new(Date.parse(current_day))
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
