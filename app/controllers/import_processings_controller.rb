class ImportProcessingsController < ApplicationController

  def create
    import = Import.find(params[:import_id])
    import.run_import_job

    redirect_to import_path(import, notice: 'Import was successfully started.')
  end
end
