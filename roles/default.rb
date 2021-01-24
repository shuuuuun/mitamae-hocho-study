execute 'echo hello world'
execute '/usr/local/bin/mitamae version'

node.reverse_merge!(
  rbenv: {
    user: 'root',
    global: '3.0.0',
    versions: %w[
      3.0.0
    ],
  }
)

include_recipe "rbenv::user"

# mysql
package 'https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm' do
  not_if 'rpm -q mysql80-community-release-el7-3'
end
package 'mysql-community-server'
package 'mysql-community-devel'

# nginx
include_recipe "../cookbooks/nginx"

# app user
node.reverse_merge!(
  users: {
    app_user_key: "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIARwuGx+Vqin2wGjGQVEqcwzDLa4RxsU8xQ4i/YSBT+u app"
  }
)
include_recipe "../cookbooks/users"
