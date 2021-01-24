package 'https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm' do
  not_if 'rpm -q mysql80-community-release-el7-3'
end

package 'mysql-community-server'
package 'mysql-community-devel'
