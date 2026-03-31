# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first

Admin.find_or_create_by!(email: "admin@example.com") do |a|
  a.password = "password"
  a.password_confirmation = "password"
end

dietary_care       = Category.find_or_create_by!(name: "食事・レシピ")
consultation       = Category.find_or_create_by!(name: "相談")
hygiene_and_safety = Category.find_or_create_by!(name: "衛生・安全管理")
night_shift        = Category.find_or_create_by!(name: "夜勤")
home_care          = Category.find_or_create_by!(name: "自宅介護")
study              = Category.find_or_create_by!(name: "資格・勉強")
career             = Category.find_or_create_by!(name: "キャリア")
relation           = Category.find_or_create_by!(name: "人間関係")
salary             = Category.find_or_create_by!(name: "給料・お金")

puts "ユーザーを作成中"

last_names = %w[佐藤 鈴木 高橋 田中 伊藤 渡辺 山本 中村 小林 加藤 吉田 山田 佐々木 山口 松本 井上 木村 林 斎藤 清水 山崎 森 池田 橋本 阿部]
first_names = %w[健太 芽依 直樹 結衣 拓海 陽子 大介 翔太 彩花 浩志 凛 太郎 翼 美咲 潤一 真緒 拓哉 健二 舞 裕太 菜月 七海 和樹 絵里 慎太郎]
nicknames = %w[さとちゃん すずっち たかさん たなやん いとくん なべさん やまさん なかむー こばちゃん かとちゃん よっしー やまちゃん ささくん ぐっさん まっちゃん MAO Taku rin saito yama yuta nana kazu eri Abe]

25.times do |n|
  user = User.find_or_create_by!(email: "test#{n}@example.com") do |u|
    u.last_name = last_names[n]
    u.first_name = first_names[n]
    u.nickname = nicknames[n]
    u.password = "password"
    u.password_confirmation = "passwprd"

    image_number = (n % 5) + 1
    image_path = Rails.root.join("db/fixtures/sample-user#{image_number}.jpg")
    
    if File.exist?(image_path)
      u.profile_image.attach(
        io: File.open(image_path),
        filename: "sample-user#{image_number}.jpg"
      )
    end
  end
end

puts "ユーザーの作成完了"


all_categories = [
  dietary_care, consultation, night_shift, hygiene_and_safety,
  home_care, study, career, relation, salary
]

puts "全カテゴリーにテスト投稿を作成中"

all_categories.each do |cat|
  20.times do |n|
    Post.create!(
      category_id: cat.id,
      user_id: User.pluck(:id).sample,
      title: "#{cat.name}のテスト投稿 No.#{n+1}",
      body: "#{cat.name}に関する本文のテストです。ページネーションの動作確認用データです。"
    )
  end
end

puts "完了"

puts "コミュニティと投稿を作成中"

group_data = [
  { name: "夜勤・交代制の広場", introduction: "夜勤の過ごし方や、交代制勤務の悩み相談" },
  { name: "食事・調理レクリエーション", introduction: "献立作成や、調理レクのアイデア共有" },
  { name: "新人・実習生指導の部屋", introduction: "教育担当の悩みや、マニュアル作成のコツ" },
  { name: "認知症ケアの知恵袋", introduction: "具体的な対応方法や、心のケアについて語り合う" },
  { name: "福祉用具", introduction: "最新の車椅子や、記録アプリの使い心地をシェア" },
  { name: "自宅介護のサポーター", introduction: "在宅介護を支える家族やヘルパーの交流場所" },
  { name: "資格試験・勉強部", introduction: "介護福祉士やケアマネ試験の合格を目指す仲間" },
  { name: "メンタル・リフレッシュ", introduction: "仕事の疲れを癒やす方法や、趣味の話題で息抜き" },
  { name: "キャリア・働き方相談室", introduction: "転職、昇進、副業など、将来のキャリアプラン" },
  { name: "記録アプリ活用術", introduction: "最新の記録ソフトやタブレット導入のコツ、使い心地をシェアしましょう。" }
]

25.times do |i|
  data = group_data[i % 10]
  rand_owner = User.all.sample

  group_name = "#{data[:name]}(#{i + 1})"

  group = Group.find_or_create_by!(name: group_name) do |c|
    c.introduction = data[:introduction]
    c.owner_id = rand_owner.id
  end
    image_number = (i % 5) + 1
    image_path = Rails.root.join("db/fixtures/sample-group#{image_number}.jpg")
    
    if File.exist?(image_path)
      group.group_image.attach(
        io: File.open(image_path),
        filename: "sample-group#{image_number}.jpg"
      )
    end
  

  15.times do |n|
    Post.create!(
      group_id: group.id,
      user_id: User.pluck(:id).sample,
      title: "#{group.name}のトピック No.#{n+1}",
      body: "これは「#{group.name}」のテスト投稿 No.#{n+1}です。",
      created_at: rand(1..100).days.ago
    )
  end
end

puts "コミュニティの作成完了"

puts "コメントの作成中"

comment_samples = [
  "その視点は気づきませんでした！参考になります。",
  "全く同感です。私も以前同じような経験をしました。",
  "具体的な対策を教えていただきありがとうございます。",
  "勉強になります。明日から現場で試してみますね。",
  "お疲れ様です。無理せず休めるときに休んでくださいね。",
  "そのやり方、いいですね！詳しく聞きたいです。",
  "わかります…。なかなか難しい問題ですよね。",
  "応援しています！"
]

Group.all.each do |group|
  User.all.sample(5).each do |user|
    GroupUser.find_or_create_by!(
      user_id: user.id,
      group_id: group.id,
      status: :accepted
    )
  end

  accepted_user_ids = group.group_users.accepted.pluck(:user_id)

  3.times do |n|
    group.posts.create!(
      title: "#{group.name}のメンバー投稿 No.#{n+1}",
      body: "コミュニティの参加者のみのテスト投稿です。",
      user_id: accepted_user_ids.sample,
    )
  end
end

Post.all.each do |post|
  rand(0..3).times do |n|
   post.post_comments.create!(
      user_id: User.pluck(:id).sample,
      content: comment_samples.sample
    )
  end
end

puts "コメントの作成完了"
