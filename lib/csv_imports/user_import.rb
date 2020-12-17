module CsvImports
  class UserImport < BaseImport

    def import_row(row)
      create_user(row)
    end

    def required_columns
      %w(first_name last_name email date_of_birth)
    end

    private

    def create_user(row)
      User.new.tap do |s|
        s.first_name = row['first_name']
        s.last_name = row['last_name']
        s.email = row['email']
        s.date_of_birth = row['date_of_birth']
      end.save
    end
  end
end
