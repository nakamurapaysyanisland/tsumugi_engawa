
ActiveRecord::Base.connection.execute("PRAGMA busy_timeout = 5000")


Admin.find_or_create_by!(email: "admin@example.com") do |a|
  a.password = "password"
  a.password_confirmation = "password"
end

categories = {
  dietary_care:       Category.find_or_create_by!(name: "食事・レシピ"),
  consultation:       Category.find_or_create_by!(name: "相談"),
  hygiene_and_safety: Category.find_or_create_by!(name: "衛生・安全管理"),
  night_shift:        Category.find_or_create_by!(name: "夜勤"),
  home_care:          Category.find_or_create_by!(name: "自宅介護"),
  study:              Category.find_or_create_by!(name: "資格・勉強"),
  career:             Category.find_or_create_by!(name: "キャリア"),
  relation:           Category.find_or_create_by!(name: "人間関係"),
  salary:             Category.find_or_create_by!(name: "給料・お金")
}

last_names = %w[佐藤 鈴木 高橋 田中 伊藤 渡辺 山本 中村 小林 加藤 吉田 山田 佐々木 山口 松本 井上 木村 林 斎藤 清水 山崎 森 池田 橋本 阿部]
first_names = %w[健太 芽依 直樹 結衣 拓海 陽子 大介 翔太 彩花 浩志 凛 太郎 翼 美咲 潤一 真緒 拓哉 健二 舞 裕太 菜月 七海 和樹 絵里 慎太郎]
nicknames = %w[さとちゃん すずっち たかさん たなやん いとくん なべさん やまさん なかむー こばちゃん かとちゃん よっしー やまちゃん ささくん ぐっさん まっちゃん MAO Taku rin saito yama yuta nana kazu eri Abe]

user_ids = []
puts "ユーザーを作成中 (25人)"
25.times do |n|
  user = User.find_or_create_by!(email: "test#{n}@example.com") do |u|
    u.last_name = last_names[n % last_names.size]
    u.first_name = first_names[n % first_names.size]
    u.nickname = nicknames[n % nicknames.size]
    u.password = "password"
    u.password_confirmation = "password"
  end
  
  image_path = Rails.root.join("db/fixtures/sample-user#{(n % 5) + 1}.jpg")
  if File.exist?(image_path) && !user.profile_image.attached?
    user.profile_image.attach(io: File.open(image_path), filename: "user.jpg")
  end
  user_ids << user.id
end

puts "全てのカテゴリーにテスト投稿を作成中"
categories.values.each do |cat|
  posts_data = 5.times.map do |n| 
    {
      category_id: cat.id,
      user_id: user_ids.sample,
      title: "#{cat.name}の投稿 No.#{n+1}",
      body: "#{cat.name}のテストです。",
      created_at: Time.current, updated_at: Time.current
    }
  end
  Post.insert_all(posts_data)
end

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
  { name: "記録アプリ活用術", introduction: "記録ソフトの使い心地をシェアしましょう。" },
  { name: "看取りと心のグリーフケア", introduction: "最期に寄り添う日々の想いや、心の整え方を分かち合う" },
  { name: "行事・レクの工作スタジオ", introduction: "季節の飾り付けや手作りプレゼントのアイデア帖" },
  { name: "多職種連携の架け橋", introduction: "看護師、リハ職、ケアマネ…他職種とのスムーズな連携のコツ" }
]

puts "コミュニティを作成中"
group_data.each_with_index do |data, i|
  group = Group.find_or_create_by!(name: data[:name]) do |c|
    c.introduction = data[:introduction]
    c.owner_id = user_ids.sample
  end

  image_path = Rails.root.join("db/fixtures/sample-group#{(i % 5) + 1}.jpg")
  if File.exist?(image_path) && !group.group_image.attached?
    group.group_image.attach(io: File.open(image_path), filename: "group.jpg")
    sleep(0.1) 
  end

  members = user_ids.sample(5)
  gu_data = members.map do |uid|
    { user_id: uid, group_id: group.id, status: 1, created_at: Time.current, updated_at: Time.current }
  end
  GroupUser.insert_all(gu_data) if gu_data.any?

  3.times do |n|
    group.posts.create!(
      user_id: members.sample,
      title: "#{group.name}のトピック No.#{n+1}",
      body: "これは「#{group.name}」のテスト投稿です。",
      created_at: rand(1..30).days.ago
    )
  end
end

puts "コメントを作成中"
comment_samples = ["同感です！", "勉強になります。", "お疲れ様です！", "いいですね！", "応援しています！"]

Post.all.each do |post|
  comments = rand(1..2).times.map do
    {
      post_id: post.id,
      user_id: user_ids.sample,
      content: comment_samples.sample,
      created_at: Time.current, updated_at: Time.current
    }
  end

  PostComment.insert_all(comments) if comments.any?
end

puts "完了しました"