require 'rails_helper'

RSpec.describe DirectoriesController, :type => :controller do
  render_views

  let(:results) { JSON.parse(response.body) }

  describe "GET 'tree'" do
    before do
      root_dir      = create(:root_dir)
      assets_dir    = root_dir.children.create(attributes_for(:assets_dir))
      documents_dir = root_dir.children.create(attributes_for(:documents_dir))
      assets_dir.children.create(attributes_for(:js_dir))
      assets_dir.children.create(attributes_for(:css_dir))

      xhr :get, :tree, format: :json
    end

    it "should respond with 200" do
      expect(response.status).to eq 200
    end

    it "should generate json with directories" do
      expect(results['name']).to eq "Root"
      expect(results['children'].map { |c| c['name'] }).to include "assets"
      expect(results['children'].map { |c| c['name'] }).to include "documents"
      expect(results['children'].map { |c| c['children'].map { |c| c['name'] } }.flatten).to include "js"
      expect(results['children'].map { |c| c['children'].map { |c| c['name'] } }.flatten).to include "css"
    end
  end

  describe "GET 'show'" do
    before do
      xhr :get, :show, format: :json, id: directory_id
    end

    context "directory exists" do
      let(:assets_dir) do
        assets_dir = create(:assets_dir, { name: 'assets',
                                           path: 'assets' })
        assets_dir.children.create(attributes_for(:js_dir))
        assets_dir
      end
      let(:directory_id) { assets_dir.id }

      it { expect(response.status).to eq 200 }
      it { expect(results['id']).to   eq assets_dir.id.to_s }
      it { expect(results['name']).to eq assets_dir.name }
      it { expect(results['path']).to eq assets_dir.path }
      it { expect(results['slug']).to eq assets_dir.slug }

      it { expect(results['content'].size).to eq 1 }
    end
  end

  describe "POST 'create'" do
    def post_new_directory_data(directory_id)
      xhr :post, :create, format: :json, directory_id: directory_id, 
        directory: attributes_for(:directory, name: 'New Directory')
    end

    context "valid data" do
      before do
        @directory = create(:directory, name: 'Sample Directory')
      end

      let(:directory) { @directory }

      it "creates new Directory" do
        expect {
          post_new_directory_data directory.id
        }.to change(Directory, :count).by(1)
      end

      it "has parent set" do
        post_new_directory_data directory.id
        expect(Directory.last.parent).to eq(directory)
      end
    end

    context "to url of non-existing parent directory" do
      it "will return 404" do
        expect {
          post_new_directory_data 123
        }.to raise_error(Mongoid::Errors::DocumentNotFound)
      end
    end
  end

  describe "POST 'name_available'" do
    let(:directory)   { create(:directory, name: 'Testing') }
    let(:sample_name) { 'Sample Name' }

    def make_post_request
      xhr :post, :name_available, format: :json, id: directory.id, 
        name: sample_name
    end

    context "name is not yet taken" do
      before { make_post_request }

      it { expect(results['is_available']).to be_truthy }
    end

    context "name is already taken" do
      before do
        directory.children.create(name: sample_name)
        make_post_request
      end

      it { expect(results['is_available']).to be_falsy }
    end
  end
end
