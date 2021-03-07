username = "app"

user "#{username}" do
  uid 505
  # gid 505
  gid "app"
  # gid "wheel"
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

file "/etc/sudoers.d/#{username}" do
  owner "root"
  group "root"
  content <<-EOS
    #{username} ALL=NOPASSWD: /bin/systemctl
  EOS
  # Cmnd_Alias PUMA_SERVICE = /bin/systemctl * puma_service
  # %#{username} ALL=(ALL) NOPASSWD: ALL
end

# for deploy
directory "/home/#{username}" do
  mode "0755"
  owner username
end
