# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :root_dir, class: Directory do
    name "Root"
  end

  factory :ice_dir, class: Directory do
    name 'ice'
  end

  factory :assets_dir, class: Directory do
    name 'assets'
  end

  factory :js_dir, class: Directory do
    name 'js'
  end

  factory :css_dir, class: Directory do
    name 'css'
  end

  factory :documents_dir, class: Directory do
    name 'documents'
  end
end
