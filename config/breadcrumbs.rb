crumb :root do
  link "ホーム", root_path
end

crumb :posts do
  link "投稿一覧", posts_path
  parent :root
end

crumb :category_post_show do |post|
  link post.title.truncate(15), post_path(post)
  parent :posts 
end

crumb :category_posts do |category|
  link "カテゴリー: #{category.name}", category_path(category)
  parent :posts
end

crumb :groups do
  link "コミュニティ一覧", groups_path
  parent :root
end

crumb :group do |group|
  link group.name.truncate(15), group_path(group)
  parent :groups
end

crumb :group_post_show do |post|
  link post.title.truncate(15), post_path(post)
  parent :group, post.group
end

crumb :group_user do |group|
  link "承認待ち一覧", group_group_users_path(group)
  parent :group, group
end

crumb :group_group_users do |group|
  link "承認一覧", group_group_users_path(group)
  parent :group, group 
end

crumb :mypage do |user|
  link "マイページ", mypage_path(user)
  parent :root
end
# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).