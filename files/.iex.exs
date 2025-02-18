Application.put_env(:elixir, :ansi_enabled, true)

inspect_limit = :infinity
inspect_width = 80

history_size = 100

timestamp = fn ->
  {_date, {hour, minute, _second}} = :calendar.local_time()

  [hour, minute]
  |> Enum.map(&String.pad_leading(Integer.to_string(&1), 2, "0"))
  |> Enum.join(":")
end

default_prompt =
  "#{IO.ANSI.green()}%prefix#{IO.ANSI.reset()} " <>
    "[#{IO.ANSI.magenta()}#{timestamp.()}#{IO.ANSI.reset()} " <>
    ":: #{IO.ANSI.cyan()}%counter#{IO.ANSI.reset()}] >"

alive_prompt =
  "#{IO.ANSI.green()}%prefix#{IO.ANSI.reset()} " <>
    "(#{IO.ANSI.yellow()}%node#{IO.ANSI.reset()}) " <>
    "[#{IO.ANSI.magenta()}#{timestamp.()}#{IO.ANSI.reset()} " <>
    ":: #{IO.ANSI.cyan()}%counter#{IO.ANSI.reset()}] >"

IEx.configure(
  width: 80,
  # auto_reload: true,
  default_prompt: default_prompt,
  alive_prompt: alive_prompt,
  history_size: history_size,
  inspect: [
    pretty: true,
    limit: inspect_limit,
    width: inspect_width,
    custom_options: [sort_maps: true]
  ],
  colors: [
    syntax_colors: [
      number: :light_magenta,
      atom: :light_cyan,
      string: :light_white,
      boolean: :red,
      nil: [:red, :bright]
    ],
    ls_directory: :cyan,
    ls_device: :yellow,
    doc_code: :green,
    doc_inline_code: :magenta,
    doc_headings: [:cyan, :underline],
    doc_title: [:cyan, :bright, :underline]
  ]
)

defmodule Helpers do
  def copy(term) do
    text =
      if is_binary(term) do
        term
      else
        inspect(term, limit: :infinity, pretty: true)
      end

    port = Port.open({:spawn, "pbcopy"}, [])
    true = Port.command(port, text)
    true = Port.close(port)

    :ok
  end
end
