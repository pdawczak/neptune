# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :root_dir, class: Directory do
    name "Root"
  end

  factory :ice_dir, class: Directory do
    name 'ice'
  end
end
