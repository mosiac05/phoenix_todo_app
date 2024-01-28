defmodule PhoenixTodoAppWeb.S3UploadsController do
  use PhoenixTodoAppWeb, :controller
  alias PhoenixTodoAppWeb.Helpers
  alias AWS

  @aws_access_key_id Application.compile_env!(:phoenix_todo_app, :aws_access_key_id)
  @aws_secret_access_key Application.compile_env!(:phoenix_todo_app, :aws_secret_access_key)
  @aws_region Application.compile_env!(:phoenix_todo_app, :aws_region)
  @aws_bucket_name Application.compile_env!(:phoenix_todo_app, :aws_bucket_name)

  def create(
        conn,
        %{
          "Content-Type" => content_type,
          "file" => %Plug.Upload{
            path: tmp_path,
            content_type: _,
            filename: file_name
          }
        } = _params
      ) do
    file_path = "public/" <> Helpers.generate_unique_file_name(file_name)

    file = File.read!(tmp_path)
    md5 = :crypto.hash(:md5, file) |> Base.encode64()

    aws_response =
      AWS.S3.put_object(get_client(), @aws_bucket_name, file_path, %{
        "Body" => file,
        "ContentMD5" => md5,
        "Content-Type" => content_type
      })

    case aws_response do
      {:ok, _, %{status_code: 200}} ->
        file_url = "https://#{@aws_bucket_name}.s3.#{@aws_region}.amazonaws.com/#{file_path}"

        send_resp(conn, 201, file_url)

      _ ->
        send_resp(conn, 400, "Unable to upload file, please try again later.")
    end
  end

  def create(conn, _) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(400, "Bad request")
  end

  defp get_client() do
    AWS.Client.create(@aws_access_key_id, @aws_secret_access_key, @aws_region)
  end
end
