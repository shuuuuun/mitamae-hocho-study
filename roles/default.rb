execute 'echo hello world'
# execute 'echo $PATH'
# execute 'export PATH=$PATH:/usr/local/bin'
# execute 'mitamae version'
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
