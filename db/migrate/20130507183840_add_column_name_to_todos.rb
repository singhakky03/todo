class AddColumnNameToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :name, :string
  end
end
