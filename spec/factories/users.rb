FactoryBot.define do
  factory :user do 
    full_name {Faker::Name.name}
    email {Faker::Internet.email}
    #avatar {Rack::Test::UploadedFile.new(Rails.root.join("spec/support/images/avatar.png"))}
    password {"123456"}
    password_confirmation {"123456"}
    role { :client }
  end
end