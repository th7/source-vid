RSpec.describe Repository do
  let(:repository) { Repository.new(url: 'https://github.com/th7/journey-tracker') }

  describe '#generate_filename' do
    it 'generates a file path from the url' do
      expect(repository.generate_filename).to eq 'github.com-th7-journey-tracker'
    end
  end
end
