FactoryGirl.define do
  factory :user do
    email 'admin@lookatme.lu'
    password '12345678'
    password_confirmation '12345678'
  end
end
