defmodule PhoenixTodoAppWeb.TodoLive do
  use PhoenixTodoAppWeb, :live_view
  alias Phoenix.HTML.Form
  alias PhoenixTodoAppWeb.Components.TodoItemComponent

  def mount(_, _, socket) do
    todo_list = [
      %{
        id: 1,
        title: "Get groceries",
        status: "active",
        description:
          "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Voluptatem, a nesciunt. Quaerat corporis nobis ex! Esse voluptatem quo eum at excepturi, ea autem qui, dignissimos quos voluptates mollitia earum quibusdam."
      },
      %{
        id: 2,
        title: "Read book",
        status: "active",
        description: nil
      },
      %{
        id: 3,
        title: "Type Research Paper",
        status: "inactive",
        description:
          "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Voluptatem, a nesciunt. Quaerat corporis nobis ex! Esse voluptatem quo eum at excepturi, ea autem qui, dignissimos quos voluptates mollitia earum quibusdam."
      },
      %{
        id: 4,
        title: "Collect the leather bag",
        status: "active",
        description:
          "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Voluptatem, a nesciunt. Quaerat corporis nobis ex! Esse voluptatem quo eum at excepturi, ea autem qui, dignissimos quos voluptates mollitia earum quibusdam."
      }
    ]

    {
      :ok,
      socket
      |> assign(
        todo_list: todo_list,
        todo_form: get_todo_form(),
        todo_description: nil
      )
    }
  end

  def handle_event(
        "text-editor",
        %{"text_content" => content, "field_name" => _field_name},
        socket
      ) do
    {:noreply, socket |> assign(todo_description: content)}
  end

  def handle_event("validate", params, socket) do
    {:noreply, socket |> assign(todo_form: to_form(params))}
  end

  def handle_event("submit-todo", params, socket) do
    {:noreply, socket |> add_new_todo(params)}
  end

  defp add_new_todo(
         %{assigns: %{todo_list: todo_list}} = socket,
         %{"description" => description, "title" => title} = _new_todo
       ) do
    new_todo = %{
      id: length(todo_list) + 1,
      status: "active",
      title: title,
      description: validate_description(description)
    }

    todo_list = todo_list |> List.insert_at(-1, new_todo)

    socket
    |> assign(
      todo_list: todo_list,
      todo_form: get_todo_form()
    )
    |> push_event("tinymce_reset", %{})
  end

  defp validate_description(description) when description in [nil, "", "<p></p>"], do: nil
  defp validate_description(description), do: description
  defp get_todo_form, do: %{"title" => nil, "description" => nil} |> to_form()
end
