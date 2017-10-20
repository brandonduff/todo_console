module Todo
  module UseCases
    class ListTodos
      def initialize(request)
        @request = request
      end

      def perform
        create_todo_directory
        current_day = Todo::DayFormatter.format(read_current_day)
        initial_buffer = task_fetcher(current_day).task_data
        tasks = Todo::TaskList.new(StringIO.new(initial_buffer))

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
        File.exist?(current_day_file) ? File.read(current_day_file).strip : ''
      end

      def current_day_file
        File.join(ENV['HOME'], '.current_day.txt')
      end

      def create_todo_directory
        Dir.mkdir(File.join(ENV['HOME'], 'todos')) unless Dir.exist?(File.join(ENV['HOME'], 'todos'))
      end

      def task_fetcher(current_day)
        fetcher = Todo::TaskListFetcher.new(Date.parse(current_day))
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
