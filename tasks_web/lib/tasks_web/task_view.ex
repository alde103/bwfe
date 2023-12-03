defmodule TasksWeb.TaskView do
  use Goldcrest.View

  def stringify_task(_task = {name, description}) do
    "<td>#{name}</td> <td>#{description}</td>"
  end
end
