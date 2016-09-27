Warden::Manager.after_set_user except: :fetch do |user, auth, _opts|
  AssignTempAssociationsJob.perform_async(user, auth)
end
