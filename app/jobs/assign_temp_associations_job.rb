class AssignTempAssociationsJob < ApplicationJob
  def perform(user, auth)
    if auth.cookies[:temp_association_uuid]
      ActiveRecord::Base.connection_pool.with_connection do
        TempAssociation.where(uuid: auth.cookies[:temp_association_uuid]).each do |temp_association|
          if temp_association.temp_associatable.update(author: user)
            temp_association.destroy
          end
        end
      end
    end
  end
end
