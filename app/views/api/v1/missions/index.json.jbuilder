json.array! @missions do |mission|
  json.extract! mission, :mission_type, :date, :price, :listing_id
end
