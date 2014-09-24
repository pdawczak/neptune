require 'rails_helper'

RSpec.describe Directory, :type => :model do
  let(:root_dir) { create(:root_dir) }
  let(:ice_dir)  { root_dir.children.create(attributes_for(:ice_dir)) }

  subject { ice_dir }

  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :slug }
  it { is_expected.to respond_to :path }

  context "with valid attributes" do
    it { is_expected.to be_valid }
  end

  describe "#accessible_ancestors" do
    subject { ice_dir.accessible_ancestors.collect(&:name) }

    it { is_expected.not_to include ice_dir.name }
    it { is_expected.not_to include root_dir.name }
  end

  describe "#accessible_ancestors_and_self" do
    subject { ice_dir.accessible_ancestors_and_self.collect(&:name) }

    it { is_expected.to     include ice_dir.name }
    it { is_expected.not_to include root_dir.name }
  end

  describe "#invalid?" do
    context "returns true when" do
      it "has no name" do
        ice_dir.name = ''
        expect(ice_dir).to be_invalid
      end

      it "directory with the same name already exists in the directory" do
        new_dir = root_dir.children.build(name: ice_dir.name)
        expect(new_dir).to be_invalid
      end
    end
  end

  describe "#slug" do
    it "has prebuilt slug" do
      expect(ice_dir.slug).to eq 'ice'
    end

    it "properly slugifies name" do
      new_dir = Directory.create(name: '_$uper.Sample_test')
      expect(new_dir.slug).to eq '$uper-dot-sample-test'
    end

    it "creates different slugs for similarly named directories" do
      ice_dir.update_attributes(name: 'ice_dir')
      another_dir = Directory.create(name: 'ice-dir')
      expect(another_dir.slug).not_to eq ice_dir.slug
    end
  end

  describe "#path" do
    context "when created" do
      it "has just the slug" do
        expect(ice_dir.path).to eq 'ice'
      end
    end

    context "when name changed" do
      it "reflects the name change" do
        ice_dir.update_attributes(name: '_tmp')
        expect(ice_dir.path).to eq 'tmp'
      end
    end

    context "for nested directories" do
      let(:sub_dir) { ice_dir.children.create(name: 'sub') }

      it "consists slugs af ancestors" do
        expect(sub_dir.path).to eq 'ice/sub'
      end

      it "it reflects the ancestor name change in path" do
        ice_dir.update_attributes(name: 'sample_ice')
        expect(sub_dir.path).to eq 'sample-ice/sub'
      end
    end
  end
end
