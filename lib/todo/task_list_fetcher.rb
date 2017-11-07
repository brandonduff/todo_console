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

    def for_week
      multi_list_fetcher_for_days_ago(7)
    end

    def for_month
      multi_list_fetcher_for_days_ago(31)
    end

    private

    def multi_list_fetcher_for_days_ago(days_ago)
      MultiTaskListFetcher.new(@reader, days_ago)
    end
  end
end
