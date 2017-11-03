module Todo
  class Task

    def initialize(description, done = false)
      @description = description
      @done = done
    end

    def description
      done? ? '✓ ' + @description : @description
    end

    def done
      Task.new(@description, true)
    end

    def undo
      Task.new(@description, false)
    end

    def in_progress?
      !done?
    end

    def done?
      @done
    end

    def to_s
      description
    end

    def ==(other)
      other.description == description && other.done? == done?
    end
  end
end
