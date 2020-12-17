class Import < ApplicationRecord
  enum status: %i[created started completed failed]

  mount_uploader :file, FileUploader

  validates :title, :file, presence: true

  def finish_import
    self.completed_at = Time.current
    completed!
  end

  def run_import_job
    ImporterJob.perform_in(1.second, id)
  end
end
