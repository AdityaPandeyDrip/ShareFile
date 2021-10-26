class SharedFileAssociation < ApplicationRecord
  belongs_to :user

  def self.get_shared_files(user_id)
    SharedFileAssociation
      .joins(:user)
      .joins('INNER JOIN active_storage_attachments ON active_storage_attachments.id = shared_file_associations.file_id AND
        active_storage_attachments.record_type = "User" AND
        active_storage_attachments.record_id = shared_file_associations.user_id ')
      .joins('INNER JOIN active_storage_blobs ON active_storage_blobs.id = active_storage_attachments.blob_id')
      .where('shared_file_associations.shared_user_id = ?', user_id)
      .select('users.email, users.id as user_id, active_storage_attachments.id as file_id, active_storage_blobs.filename, active_storage_blobs.byte_size,shared_file_associations.id, shared_file_associations.created_at')
  end
end

