RSpec.describe RepositoriesController do
  describe 'GET index' do
    it 'assignes @repositories' do
      get :index
      expect(assigns(:repositories)).to eq ['stubbed']
    end
  end
end
