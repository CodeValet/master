FROM nginx:alpine
USER root

RUN apk add --no-cache supervisor

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000

ENV JENKINS_HOME /var/jenkins_home
# Jenkins is run with user `jenkins`, uid = 1000
# If you bind mount a volume from the host or a data container,
# ensure you use the same uid
RUN addgroup -g ${gid} ${group} \
    && adduser -h "$JENKINS_HOME" -u ${uid} -G ${group} -s /bin/bash -D ${user}

# Prepare the nginx instance itself
################################################################################
COPY nginx.conf /etc/nginx/conf.d/default.conf
################################################################################

# Prepare the supervisor script to run nginx and Jenkins inside the container
################################################################################
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
################################################################################
