if node[:platform] == 'centos' || node[:platform] == 'redhat'
  execute 'yum -y install yum-utils'
  file "/etc/yum.repos.d/nginx.repo" do
    content \
      '[nginx-stable]' "\n" \
      'name=nginx stable repo' "\n" \
      'baseurl=http://nginx.org/packages/centos/$releasever/$basearch/' "\n" \
      'gpgcheck=1' "\n" \
      'enabled=1' "\n" \
      'gpgkey=https://nginx.org/keys/nginx_signing.key' "\n" \
      'module_hotfixes=true' "\n"
  end

  case node[:platform_version].to_i
  when 7
    package 'http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm' do
      not_if 'rpm -q nginx'
    end
  when 8
    execute 'dnf -y module disable nginx' # disable default module
  end
elsif node[:platform] == 'amazon'
  case node[:platform_version].to_i
  when 2
    execute 'amazon-linux-extras install nginx1'
  end
end

package "nginx" do
  action :install
end

file "/etc/nginx/conf.d/default.conf" do
  action :delete
end

template "/etc/nginx/conf.d/app.conf" do
  source "templates/app.conf.erb"
  owner "root"
  group "root"
  mode "644"
  # notifies :run, "execute[restart nginx]"
  notifies :restart, "service[nginx]"
  variables(
    app_sock: node[:nginx][:app_sock] || "unix:///var/run/puma/app.sock",
    root: node[:nginx][:root] || "/var/app/current/public"
  )
end

# execute "restart nginx"  do
#   command "/etc/init.d/nginx restart"
# end
service "nginx" do
  action [:start,:enable]
end
# service "nginx" do
#   action :restart
#   subscribes :run, "template[/etc/nginx/nginx.conf]"
# end
