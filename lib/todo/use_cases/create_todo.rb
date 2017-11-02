module Todo
  module UseCases
    class CreateTodo
      def initialize(todo_text)
        @todo_text = todo_text
      end

      def perform
        file = File.open(todo_file, 'a')
        file.puts(@todo_text)
        file.close
      end

      def todo_file
        env_helper = EnvHelper.new
        current_day = Reader.new(env_helper).current_day
        env_helper.todo_path + current_day.strip + '.txt'
      end
    end
  end
end
