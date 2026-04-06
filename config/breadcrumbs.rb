crumb :root do
  link "ホーム", root_path
end

crumb :posts do
  link "投稿一覧", posts_path
  parent :root
end

crumb :category_post_show do |post|
  link post.title, post_path(post)
  parent :posts 
end

crumb :groups do
  link "グループ一覧", groups_path
  parent :root
end

crumb :group do |group|
  link group.name, group_path(group)
  parent :groups
end

crumb :group_post_show do |post|
  link post.title, group_post_path(post.group, post)
  parent :group, post.group
end

crumb :group_user do |group|
  link "承認待ち一覧", group_memberships_path(group)
  parent :group, group
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