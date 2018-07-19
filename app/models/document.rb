class Document < ApplicationRecord
  belongs_to :comment
  mount_uploader :document, DocumentUploader
end
