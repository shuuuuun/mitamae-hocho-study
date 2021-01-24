FROM ubuntu:latest

ARG USER=root
ARG PASS=pass

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo "$USER:$PASS" | chpasswd
# RUN passwd -d $USER
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication/PasswordAuthentication/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# WORKDIR /root/.ssh

# COPY .ssh/id_rsa.pub ./
# COPY .ssh/id_ed25519.pub ./

# RUN set -ex \
#   && cat ./id_rsa.pub >> ./authorized_keys \
#   && cat ./id_ed25519.pub >> ./authorized_keys \
#   && chmod 600 ./authorized_keys \
#   && chmod 700 .

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
