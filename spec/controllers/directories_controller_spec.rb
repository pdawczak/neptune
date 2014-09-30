require 'rails_helper'

RSpec.describe DirectoriesController, :type => :controller do
  render_views

  describe "GET 'tree'" do
    before do
      root_dir      = create(:root_dir)
      assets_dir    = root_dir.children.create(attributes_for(:assets_dir))
      documents_dir = root_dir.children.create(attributes_for(:documents_dir))
      assets_dir.children.create(attributes_for(:js_dir))
      assets_dir.children.create(attributes_for(:css_dir))

      xhr :get, :tree, format: :json
    end

    let(:results) { JSON.parse(response.body) }

    it "should respond with 200" do
      expect(response.status).to eq 200
    end

    it "should generate json with directories" do
      expect(results['name']).to eq "Root"
      expect(results['children'][0]['name']).to eq "assets"
      expect(results['children'][1]['name']).to eq "documents"
      expect(results['children'][0]['children'][0]['name']).to eq "js"
      expect(results['children'][0]['children'][1]['name']).to eq "css"
    end
  end
end
