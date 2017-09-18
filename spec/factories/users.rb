FactoryGirl.define do
  factory :user, class: 'User' do
    approved true
    name     'Test Name'
    email    'test@test.com'
    password '123456'
  end
end
