namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   location: "Storrs, CT")
    end

    99.times do |a|
      ApiKey.create!(user_id: a)
    end

    admin = User.create!(name: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         admin: true)
    ApiKey.create!(user_id: 100)

    # Add sample tags to the database
    Tag.create!(name: "antiques")
    Tag.create!(name: "appliances")
    Tag.create!(name: "bikes")
    Tag.create!(name: "auto parts")
    Tag.create!(name: "boats")
    Tag.create!(name: "books")
    Tag.create!(name: "cars+trucks")
    Tag.create!(name: "business")
    Tag.create!(name: "computer")
    Tag.create!(name: "free")
    Tag.create!(name: "furniture")
    Tag.create!(name: "general")
    Tag.create!(name: "electronics")
    Tag.create!(name: "household")
    Tag.create!(name: "video gaming")


    users = User.all(limit: 6)
    tagArray = Tag.all.to_a
    50.times do
      content = Faker::Lorem.sentence(5)
      post_title = Faker::Lorem.sentence(1)
      tag = tagArray[rand(tagArray.length)]
      #users.each { |user| user.microposts.create!(content: content, post_title: post_title, tag: tag.name) }
    end
  end
end
