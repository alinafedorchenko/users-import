require 'rails_helper'

RSpec.describe CsvImports::UserImport do
  let(:file) { File.new('spec/fixtures/csv/valid_import.csv') }
  subject(:importer) { create(:user_import, file: file) }

  describe '#import' do
    context 'with valid csv' do
      it 'creates students' do
        expect { importer.import }.to change { User.count }.by(3)
      end

      it 'updates import status to completed' do
        importer.import
        expect(importer.status).to eq('completed')
      end
    end

    context 'with invalid rows in csv' do
      let(:file) { File.new('spec/fixtures/csv/invalid_import_data.csv') }

      it 'does not creates students' do
        expect { importer.import }.to change { User.count }.by(0)
      end
    end

    context 'with invalid rows in csv' do
      let(:file) { File.new('spec/fixtures/csv/invalid_headers.csv') }

      it_behaves_like 'csv importing with invalid file'
    end

    context 'with invalid file' do
      let(:file) { File.new('spec/fixtures/csv/invalid_file.csv') }

      it_behaves_like 'csv importing with invalid file'
    end
  end
end
