class ImporterJob < BaseJob
  def perform(importer_id)
    importer = Import.find(importer_id)
    importer.import
  end
end
