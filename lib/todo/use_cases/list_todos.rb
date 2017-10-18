module Todo
  module UseCases
    class ListTodos
      def initialize(request)
        @request = request
      end

      def perform
        Dir.mkdir(File.join(ENV['HOME'], 'todos')) unless Dir.exist?(File.join(ENV['HOME'], 'todos'))
        @current_day = Todo::DayFormatter.format(read_current_day)
        @todo_file = File.join(ENV['HOME'], 'todos', "#{Date.parse(@current_day).strftime("%d-%m-%Y")}.txt")
        initial_buffer = task_fetcher(@request).task_data
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

      def task_fetcher(global)
        fetcher = Todo::TaskListFetcher.new(Date.parse(@current_day))
        if global[:month]
          fetcher.for_month
        elsif global[:week]
          fetcher.for_week
        else
          fetcher
        end
      end
    end
  end
end
