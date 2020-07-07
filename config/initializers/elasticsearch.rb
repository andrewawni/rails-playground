# frozen_string_literal: true

unless Todo.__elasticsearch__.index_exists?
  Todo.__elasticsearch__.create_index! force: true
  Todo.import
end
