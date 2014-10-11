# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :directory do
    factory :root_dir       do name 'Root'      end
    factory :ice_dir        do name 'ice'       end
    factory :assets_dir     do name 'assets'    end
    factory :js_dir         do name 'js'        end
    factory :css_dir        do name 'css'       end
    factory :documents_dir  do name 'documents' end
  end
end
