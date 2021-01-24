execute 'echo hello world'
execute '/usr/local/bin/mitamae version'

# rbenv
node.reverse_merge!(
  rbenv: {
    global: '3.0.0',
    versions: %w[
      3.0.0
    ],
  }
)
include_recipe "rbenv::system"
file "/etc/profile.d/rbenv.sh" do
  mode "0644"
  # content <<~EOS.chomp
  #   export RBENV_ROOT=/usr/local/rbenv
  #   export PATH="${RBENV_ROOT}/bin:${PATH}"
  #   eval "$(rbenv init -)"
  # EOS
  content \
    'export RBENV_ROOT=/usr/local/rbenv' "\n" \
    'export PATH="${RBENV_ROOT}/bin:${PATH}"' "\n" \
    'eval "$(rbenv init -)"'
end

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
