require_relative 'test_helper'
require 'todo/persistence'

class TaskTest < Minitest::Test
  def test_saving_obj_to_buffer
    object_to_persist = double('object')
    buffer = double('StringIO')
    expect(buffer).to receive(:truncate).with(0)
    expect(buffer).to receive(:puts).with(object_to_persist)

    Todo::Persistence.for(object_to_persist).write_to(buffer)
  end
end
