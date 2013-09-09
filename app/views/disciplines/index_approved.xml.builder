xml.instruct!
xml.data do
  @disciplines.each do |item|
    xml.item do
      xml.id item.id
      xml.date item.created_at
      xml.user item.user.name
      xml.dyscName item.name
      xml.dyscDescr item.description
      xml.votes item.votes_count
    end
  end
end
