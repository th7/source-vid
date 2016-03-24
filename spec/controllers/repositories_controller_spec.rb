RSpec.describe RepositoriesController do
  describe 'GET index' do
    it 'assignes @repositories' do
      repo = Repository.create(url: 'hi mom')
      get :index
      expect(assigns(:repositories)).to eq [repo]
    end
  end
end
