module Todo
  class Reader
    def initialize(env_helper)
      @env_helper = env_helper
    end

    def current_day
      File.exist?(@env_helper.current_day_path) ? File.read(@env_helper.current_day_path).strip : ''
    end
  end
end
