FactoryBot.define do
  factory :import do
    file { File.new('spec/fixtures/csv/valid_import.csv') }
    title { 'Test import' }
  end

  factory :user_import, parent: :import, class: UserImport do
    file { File.new('spec/fixtures/csv/valid_import.csv') }
    title { 'Test student import' }
  end
end
