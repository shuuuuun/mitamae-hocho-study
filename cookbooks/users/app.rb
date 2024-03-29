username = "app"

user "#{username}" do
  uid 505
  gid "app"
end

directory "/home/#{username}/.ssh" do
  mode "0755"
  owner username
end

file "/home/#{username}/.ssh/authorized_keys" do
  mode "0644"
  owner username
  content node[:users][:app_user_key]
end

# for deploy
directory "/var/app" do
  mode "0755"
  owner username
end
