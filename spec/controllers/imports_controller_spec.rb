require 'rails_helper'

RSpec.describe ImportsController do
  describe 'GET /imports' do
    before { get :index }

    it 'responds with success' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all imports' do
      create_list(:import, 3)
      expect(assigns(:imports)).to eq(Import.all)
    end
  end

  describe 'GET /show' do
    before { get :show, params: { id: importer.id } }
    let(:importer) { create :import }

    it 'responds with success' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns specific import' do
      expect(assigns(:import)).to eq(importer)
    end
  end

  describe 'POST /create' do
    subject(:request) { post :create, params: { import: params, 'importer_type' => importer_type } }
    let(:params) do
      {
        'file' => file,
        'title' => 'New user import'
      }
    end

    let(:importer_type) { 'UserImport' }
    let(:file) { fixture_file_upload('csv/valid_import.csv') }

    context 'valid params' do
      it 'creates new import' do
        expect { request }.to change { Import.count }.by(1)
      end

      it 'creates new import with given fields' do
        request
        expect(Import.last.title).to eq(params['title'])
      end
    end

    context 'invalid params' do
      it 'does not create new import' do
        params['title'] = nil
        expect { request }.to change { Import.count }.by(0)
      end

      context 'importer_type' do
        let(:importer_type) { nil }

        it 'raises an exception' do
          expect { request }.to raise_error(ActionController::BadRequest)
        end
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:importer) { create :import }
    subject(:request) { delete :destroy, params: { id: importer.id } }

    it 'destroys the requested import' do
      expect { request }.to change { Import.count }.by(-1)
    end
  end

  describe 'PATCH /update' do
    let(:importer) { create :import }
    subject(:request) { patch :update, params: { id: importer.id, import: params } }
    let(:params) do
      {
        'title' => 'Updated title'
      }
    end

    it 'updates the requested import' do
      request
      expect(importer.reload.title).to eq(params['title'])
    end
  end
end
