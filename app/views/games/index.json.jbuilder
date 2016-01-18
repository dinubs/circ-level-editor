json.array!(@games) do |game|
  json.extract! game, :id, :name, :slug, :map, :completions
  json.url game_url(game, format: :json)
end
