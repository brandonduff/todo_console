module Todo
  class TaskItem
    attr_reader :description

    def initialize(description)
      @description = description
    end

    def done
      @description = '✓ ' + @description
    end

    def in_progress?
      !done?
    end

    def done?
      @description.include?('✓')
    end
  end
end