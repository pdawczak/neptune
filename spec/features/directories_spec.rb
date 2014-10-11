require 'rails_helper'

feature 'Directories', js: true do
  def build_tree
    create(:root_dir) do |root|
      root.children  = [
        build(:assets_dir) do |assets|
          assets.children = [
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

    expect(breadcrumbs).to have_content 'Root'

    within('#directory-tree') do
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

  scenario "Navigating between directories via directory content" do
    content = find('#directory-content')

    within(content) do
      expect(content).not_to have_content '..'
      expect(content).to     have_content 'assets'
      expect(content).to     have_content 'documents'
      
      click_on 'assets'
      expect(content).to     have_content '..'
      expect(content).to     have_content 'js'
      expect(content).to     have_content 'css'
      expect(content).not_to have_content 'assets'
      expect(content).not_to have_content 'documents'

      click_on '..'
      expect(content).not_to have_content '..'
      expect(content).not_to have_content 'js'
      expect(content).not_to have_content 'css'
      expect(content).to     have_content 'assets'
      expect(content).to     have_content 'documents'
    end
  end

  scenario "creating new directories" do
    newDirectoryName = 'New Directory'

    content = find('#directory-content')
    expect(content).not_to have_content newDirectoryName

    find('#new-directory').click
    within('.new-directory-form') do
      fill_in 'Name...', with: newDirectoryName
    end
    click_on 'Create'

    expect(content).to have_content newDirectoryName
  end
end
