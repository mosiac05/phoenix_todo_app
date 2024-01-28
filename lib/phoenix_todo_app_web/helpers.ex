defmodule PhoenixTodoAppWeb.Helpers do
  def generate_unique_file_name(file_name) do
    current_timestamp = System.os_time(:second)
    file_extension = file_name |> Path.extname()

    file_base_name =
      file_name
      |> String.split(file_extension)
      |> List.first()
      |> String.replace(" ", "-")

    "#{file_base_name}-#{current_timestamp}#{file_extension}"
  end
end
