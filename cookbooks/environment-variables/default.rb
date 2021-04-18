# TODO: 環境変数の設定方法を要検討

# pp ENV.fetch("RAILS_MASTER_KEY")
# mitamaeはhochoによりリモートで実行されるため、ローカルのENVが入ってないっぽい

# for Rails app
# file "/etc/environment" do
#   action :edit
#   not_if "test $RAILS_MASTER_KEY"
#   block do |content|
#     content << %(export RAILS_MASTER_KEY="#{ENV.fetch("RAILS_MASTER_KEY")}"\n)
#   end
# end

# refs:
# * https://t4traw.net/2018/07/26/
# * https://github.com/sorah/itamae-secrets
#   * https://qiita.com/takeshy/items/8311aeb57426779f9755#env
# * https://github.com/eagletmt/mitamae-secrets
#   * https://eagletmt.hateblo.jp/entry/2016/12/11/222014
# * https://github.com/sue445/itamae-plugin-resource-encrypted_remote_file
#   * https://sue445.hatenablog.com/entry/2015/05/09/185807
