FactoryBot.define do
  factory :article do
    title { 'test' }
    url { 'https://tester/index.html' }
    content { 'test' }
  end
end