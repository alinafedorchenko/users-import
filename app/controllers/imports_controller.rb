class ImportsController < ApplicationController
  before_action :set_import, only: [:show, :edit, :update, :destroy]

  def index
    @imports = Import.all
  end

  def show
  end

  def new
    @import = Import.new
  end

  def create
    import = get_importer(params[:importer_type]).new(import_params)

    if import.save
      redirect_to import_path(import, notice: 'Import was successfully created.')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @import.update(import_params)
      redirect_to @import, notice: 'Import was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @import.destroy
    redirect_to imports_url, notice: 'Import was successfully destroyed.'
  end

  private

  def set_import
    @import = Import.find(params[:id])
  end

  def import_params
    params.require(:import).permit(:title, :file)
  end

  def get_importer(type = nil)
    raise ActionController::BadRequest unless type.present? || type.underscore.camelize.presence_in(%w(UserImport))

    importer_class_name = type.underscore.camelize.presence_in(%w(UserImport))
    importer_class_name.constantize
  end
end
