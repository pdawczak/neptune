require 'rails_helper'

feature 'Directories', js: true do
  def build_tree
    create(:root_dir) do |r|
      r.children  = [
        build(:assets_dir) do |a|
          a.children = [
            build(:js_dir),
            build(:css_dir)
          ]
        end,
        build(:documents_dir)
      ]
    end
  end

  before do
    build_tree

    visit '/'
    click_on 'Browser'
  end

  scenario 'Displaying directory list' do
    directory_items = find('#directory-tree').all('.directory-item')

    expect(directory_items[0]).to have_content 'assets'
    expect(directory_items[1]).to have_content 'css'
    expect(directory_items[2]).to have_content 'js'
    expect(directory_items[3]).to have_content 'documents'
  end

  scenario 'Rendering breadcrumbs when navigating between directories' do
    breadcrumbs = find('#directory-breadcrumbs')

    expect(breadcrumbs).to have_content ''

    click_on 'assets'
    expect(breadcrumbs).to have_content 'assets'

    click_on 'js'
    expect(breadcrumbs).to have_content 'assets'
    expect(breadcrumbs).to have_content 'js'

    click_on 'documents'
    expect(breadcrumbs).to     have_content 'documents'
    expect(breadcrumbs).not_to have_content 'assets'
    expect(breadcrumbs).not_to have_content 'js'
  end
end
