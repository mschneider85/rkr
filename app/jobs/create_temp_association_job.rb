class CreateTempAssociationJob < ApplicationJob
  def perform(object, uuid)
    object.create_temp_association(uuid: uuid) if uuid
  end
end
