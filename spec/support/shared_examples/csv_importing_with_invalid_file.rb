RSpec.shared_examples 'csv importing with invalid file' do
  it 'updates import status to failed' do
    importer.import
    expect(importer.status).to eq('failed')
  end
end
