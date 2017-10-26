module Todo
  class EnvHelper
    def current_day_path
      File.join(ENV['HOME'], '.current_day.txt')
    end

    def todo_path
      File.join(ENV['HOME'], 'todos/')
    end
  end
end
