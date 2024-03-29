if node[:platform] == 'centos' || node[:platform] == 'redhat'
  case node[:platform_version].to_i
  when 7
    package 'https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm' do
      not_if 'rpm -q mysql80-community-release-el7-3'
    end
  when 8
    execute 'dnf -y localinstall https://dev.mysql.com/get/mysql80-community-release-el8-1.noarch.rpm'
    execute 'dnf -y module disable mysql' # disable default module
  end
elsif node[:platform] == 'amazon'
  case node[:platform_version].to_i
  when 2
    package 'https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm' do
      not_if 'rpm -q mysql80-community-release-el7-3'
    end
  end
end

if %w[centos redhat amazon].include?(node[:platform])
  package 'mysql-community-server'
  package 'mysql-community-devel'
elsif %w[ubuntu].include?(node[:platform])
  package 'mysql-server'
  package 'mysql-client'
end
