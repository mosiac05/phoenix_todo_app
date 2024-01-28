defmodule PhoenixTodoAppWeb.Components.TodoItemComponent do
  use PhoenixTodoAppWeb, :live_component

  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
      |> assign(status_form: %{"status" => assigns.todo_item.status}, show_description: false)
    }
  end

  def handle_event("toggle-description", _, socket) do
    {:noreply, socket |> toggle_description()}
  end

  def handle_event("status-change", %{"status" => status}, socket) do
    {:noreply, socket |> change_status(status)}
  end

  def render(assigns) do
    ~H"""
    <div
      id={"todo-item-component-#{@todo_item.id}"}
      class="flex flex-col gap-2 border border-gray-100 px-4 py-2 shadow-sm"
    >
      <div class="flex justify-between items-center">
        <div class="flex gap-4 items-center">
          <.form
            :let={f}
            for={@status_form}
            id={"status-form-#{@todo_item.id}"}
            phx-change="status-change"
            phx-target={@myself}
          >
            <.input type="checkbox" field={f[:status]} checked={@todo_item.status == "inactive"} />
          </.form>
          <span class={[
            "text-sky-700",
            @todo_item.status == "inactive" && "line-through decoration-gray-400 decoration-1"
          ]}>
            <%= @todo_item.title %>
          </span>
        </div>
        <%= if @show_description do %>
          <span phx-click="toggle-description" phx-target={@myself}>
            <.icon name="hero-chevron-up" class="h-5 w-5 opacity-40 group-hover:opacity-70" />
          </span>
        <% else %>
          <span phx-click="toggle-description" phx-target={@myself}>
            <.icon name="hero-chevron-down" class="h-5 w-5 opacity-40 group-hover:opacity-70" />
          </span>
        <% end %>
      </div>
      <div class={[
        "text-xs font-light prose prose-neutral",
        is_nil(@todo_item.description) && "text-gray-500 italic",
        !@show_description && "hidden"
      ]}>
        <%= if @todo_item.description, do: raw(@todo_item.description), else: "No description." %>
      </div>
    </div>
    """
  end

  defp change_status(%{assigns: %{todo_item: todo_item}} = socket, "true"),
    do: socket |> assign(todo_item: %{todo_item | status: "inactive"})

  defp change_status(%{assigns: %{todo_item: todo_item}} = socket, _),
    do: socket |> assign(todo_item: %{todo_item | status: "active"})

  defp toggle_description(%{assigns: %{show_description: show_description}} = socket),
    do: socket |> assign(show_description: !show_description)
end
