group "app" do
  gid 505
end

file "/etc/sudoers.d/app" do
  owner "root"
  group "root"
  content <<-EOS
    %app ALL= NOPASSWD: ALL
  EOS
  # %app ALL=NOPASSWD: /bin/systemctl
end

include_recipe "./app"
