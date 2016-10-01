class EvaluateVote
  def self.call(attributes = {})
    attributes = attributes.slice(:votable, :voter, :value)
    if attributes.any? && Vote.exists?(attributes)
      Vote.find_by(attributes).destroy
    else
      vote = Vote.where(attributes.except(:value)).first_or_initialize
      vote.value = attributes[:value]
      vote.save
    end
  end
end
