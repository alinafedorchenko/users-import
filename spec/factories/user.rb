FactoryBot.define do
  factory :user do
    first_name { 'Eric' }
    last_name { 'Cartman' }
    email { 'test@email.com' }
    date_of_birth { Time.current - 21.years }
  end
end
