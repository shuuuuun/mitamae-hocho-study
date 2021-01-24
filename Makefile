MITAMAE_VERSION := 1.11.7

# SUDO_PASSWORD := pass
# SUDO_PASSWORD := ''
# export SUDO_PASSWORD

.PHONY: setup
setup:
	curl -L -o /usr/local/bin/mitamae https://github.com/itamae-kitchen/mitamae/releases/download/v${MITAMAE_VERSION}/mitamae-x86_64-linux
	chmod +x /usr/local/bin/mitamae
	mitamae version

.PHONY: run
run:
	mitamae local --plugins=./plugins lib/recipe.rb

.PHONY: rsync
rsync:
	rsync -ahvc --append-verify . ${REMOTE_HOST}:~/mitamae

# $ docker build -t eg_sshd .
# $ docker run -d -P --name test_sshd eg_sshd
# $ docker run -itd -p 2222:22 test_sshd eg_sshd

# $ docker container stop test_sshd
# $ docker container prune
# $ docker container ls

# mkdir -p .ssh
# ssh-keygen -t rsa -b 2048 -C "root" -f .ssh/id_rsa
# ssh-keygen -t ed25519 -C "root" -f .ssh/id_ed25519

vagrant/up:
	vagrant up

vagrant/status:
	vagrant status

vagrant/ssh:
	vagrant ssh

vagrant/ssh-config:
	vagrant ssh-config

vagrant/destroy:
	vagrant destroy

vagrant/refresh-knownhosts:
	ssh-keygen -R '[127.0.0.1]:2222'

docker/up:
	docker-compose up

docker/ssh:
	ssh root@0.0.0.0 -p 2222

hocho/list:
	bundle exec hocho list

hocho/show/%:
	bundle exec hocho show $*

hocho/apply/%/dry-run:
	bundle exec hocho apply --dry-run $*

hocho/apply/%:
	bundle exec hocho apply $*
