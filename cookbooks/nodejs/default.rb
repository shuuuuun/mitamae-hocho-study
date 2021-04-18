if %w[centos redhat amazon].include?(node[:platform])
  execute 'curl -fsSL https://rpm.nodesource.com/setup_14.x | bash -' do
    not_if 'command -v node'
    # not_if 'yum list installed | grep nodejs'
  end
  # execute 'yum install -y nodejs'
  # execute "create an empty file" do
  #   command "touch /path/to/file"
  #   not_if "test -e /path/to/file"
  # end
elsif %w[ubuntu].include?(node[:platform])
  execute 'curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -' do
    not_if 'command -v node'
  end
  # execute 'apt-get install -y nodejs'
end

package 'nodejs'

execute 'node --version'
execute 'npm --version'
