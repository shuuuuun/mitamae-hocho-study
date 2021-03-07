package 'http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm' do
  not_if 'rpm -q nginx'
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
  variables(
    # app_sock: "unix:///var/run/puma/my_app.sock"
    app_sock: "unix:///home/app/capistrano-study/shared/tmp/sockets/puma.sock",
    # root: "/var/app/current/public"
    root: "/home/app/capistrano-study/current/public"
  )
end

# directory "/var/log/nginx" do
#   owner node[:user][:name]
#   group node[:user][:name]
#   mode "755"
# end

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
