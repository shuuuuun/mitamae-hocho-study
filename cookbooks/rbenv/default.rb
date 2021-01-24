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
