FactoryBot.define do

  factory :user do
    sequence :email {|n| "dummyEmail#{n}@gmail.com" }
    add_attribute(:password) { "secretPassword" }
    add_attribute(:password_confirmation) { "secretPassword" }
  end

  factory :page do
    long_url { 'https://www.testlink.com/very-very/long-link' }
    short_url { 'shorty' }
    counter { 0 }
    association :user

    trait :other_users do
      long_url { 'https://www.another-users-long-link' }
    end
  end
end
