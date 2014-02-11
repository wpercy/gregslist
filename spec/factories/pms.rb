# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pm do
    sender_id 1
    recipient_id 1
    message "MyString"
  end
end
