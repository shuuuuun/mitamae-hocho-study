execute 'echo hello world'
execute '/usr/local/bin/mitamae version'
execute 'yum update -y systemd'

# options
node.reverse_merge!(
  rbenv: {
    global: '3.0.0',
    versions: %w[
      3.0.0
    ],
  },
  users: {
    app_user_key: "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIARwuGx+Vqin2wGjGQVEqcwzDLa4RxsU8xQ4i/YSBT+u app"
  },
)

# recipe
include_recipe "../cookbooks/rbenv"
include_recipe "../cookbooks/mysql"
include_recipe "../cookbooks/nginx"
include_recipe "../cookbooks/users"
