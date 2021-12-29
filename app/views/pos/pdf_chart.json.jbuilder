json.data do
    json.array!(@data) do |installment|
        json.po installment.po_id
        if installment.position.present?
          json.x  'Installment ' + installment.position.to_s
        end
        json.value installment.percentage
    end 
end