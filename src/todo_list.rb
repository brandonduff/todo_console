class TodoList
  attr_reader :todos

  def initialize
    @todos = []
  end
  
  def add_todo(text)
    @todos << text
  end

  def to_s
    @todos.join('\n')
  end

  def save(buffer)
    buffer << to_s
  end
end
