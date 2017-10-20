module Todo
  class TaskListFetcher
    def initialize(day)
      @day = day
    end

    def task_data
      File.exist?(todo_file) ? File.read(todo_file) : ''
    end

    def todo_file
      File.join(ENV['HOME'], 'todos', day_string + '.txt')
    end

    def for_week
      multi_list_fetcher_for_days_ago(7)
    end

    def for_month
      multi_list_fetcher_for_days_ago(31)
    end

    private

    def multi_list_fetcher_for_days_ago(days_ago)
      MultiTaskListFetcher.new(Range.new(@day - days_ago, @day))
    end

    def day_string
      @day.strftime("%d-%m-%Y")
    end
  end
end
