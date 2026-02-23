# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
salary   = Category.find_or_create_by!(name: "給料")
hygiene  = Category.find_or_create_by!(name: "衛生管理")
relation = Category.find_or_create_by!(name: "人間関係")
content  = Category.find_or_create_by!(name: "仕事の内容")

puts "seedの実行を開始"

山田 = User.find_or_create_by!(email: "ichiro@example.com") do |user|
  user.first_name = "一郎"
  user.last_name = "山田"
  user.nickname = "イチロー"
  user.password = "password123" 
  user.password_confirmation = "password123"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

鈴木 = User.find_or_create_by!(email: "jiro@example.com") do |user|
  user.first_name = "士郎"
  user.last_name = "鈴木"
  user.nickname = "シロ"
  user.password = "password1234" 
  user.password_confirmation = "password1234"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

佐藤 = User.find_or_create_by!(email: "sato@example.com") do |user|
  user.first_name = "花子"
  user.last_name = "佐藤"
  user.nickname = "ハナ"
  user.password = "password12345" 
  user.password_confirmation = "password12345"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end

Post.find_or_create_by!(title: "冬と夏の衛生管理について") do |post|
  post.body = "ここに投稿の本文が入ります。seedsで自動生成されました。"
  post.category = hygiene
  post.user_id = 山田.id
end

Post.find_or_create_by!(title: "賞与について") do |post|
  post.body = "ここに投稿の本文が入ります。seedsで自動生成されました。"
  post.category = salary
  post.user_id = 鈴木.id
end

Post.find_or_create_by!(title: "人間関係に悩んでいます") do |post|
  post.body = "ここに投稿の本文が入ります。seedsで自動生成されました。"
  post.category = relation
  post.user_id = 佐藤.id
end

puts "seedの実行が完了しました"