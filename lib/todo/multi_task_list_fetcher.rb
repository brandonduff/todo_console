module Todo
  class MultiTaskListFetcher
    def initialize(date_range)
      @date_range = date_range
    end

    def task_data
      @date_range.each.inject('') do |res, date|
        res += TaskListFetcher.new(date).task_data
      end
    end
  end
end
