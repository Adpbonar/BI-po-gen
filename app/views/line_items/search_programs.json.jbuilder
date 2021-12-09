json.saved_items do
    json.array!(@r) do |item|
        json.name item.title
        json.url "#" + item.title.split(" ").join.downcase.to_s.gsub!(/[^0-9A-Za-z]/, '')
    end 
end