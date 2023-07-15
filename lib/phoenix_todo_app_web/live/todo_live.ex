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
        todo_form: to_form(%{"title" => nil, "description" => nil})
      )
    }
  end
end
