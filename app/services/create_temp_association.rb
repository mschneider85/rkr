class CreateTempAssociation
  def self.call(object, uuid)
    object.create_temp_association(uuid: uuid) if uuid
  end
end
