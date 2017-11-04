module Todo
  class TaskListFetcher
    def initialize(reader)
      @reader = reader
    end

    def tasks_for_day(day)
      task_data = @reader.task_data_for_day(day)
      TaskList.new.tap do |task_list|
        task_data.each do |task|
          task_list.add_task(TaskBuilder.new(task).build)
        end
      end
    end

    def for_week(day)
      multi_list_fetcher_for_days_ago(7, day)
    end

    def for_month(day)
      multi_list_fetcher_for_days_ago(31, day)
    end

    private

    def multi_list_fetcher_for_days_ago(days_ago, day)
      MultiTaskListFetcher.new(Range.new(day - days_ago, day))
    end
  end
end
