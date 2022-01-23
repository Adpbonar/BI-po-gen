module InvoicesHelper
  def people
    participants = []
    participants << [" ", nil]
    Participant.all.order(:id).each do |person|
      participants << [person.name + ' (' + person.type + ')', person.id]
    end
    return participants
  end

  def pos
    pos = []
    pos << [" ", nil]
    Po.all.order(:id).each do |bi_po|
      pos << [bi_po.po_number. to_s + ": " + (bi_po.title), bi_po.id]
    end
    return pos
  end
end
