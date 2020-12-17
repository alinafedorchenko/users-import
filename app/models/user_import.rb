class UserImport < Import

  def import
    CsvImports::UserImport.new(self).import
  end
end
