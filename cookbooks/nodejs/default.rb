if %w[centos redhat amazon].include?(node[:platform])
  execute 'curl -fsSL https://rpm.nodesource.com/setup_14.x | bash -' do
    not_if 'command -v node'
  end
elsif %w[ubuntu].include?(node[:platform])
  execute 'curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -' do
    not_if 'command -v node'
  end
end

package 'nodejs'

execute 'node --version'
execute 'npm --version'
