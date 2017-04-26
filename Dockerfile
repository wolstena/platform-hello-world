FROM wolstena/nginx-ssl-secure
MAINTAINER MarvAmBass
MAINTAINER Paul Wolstenholme <pwolstenholme@central1.com>

# RUN apk add --update gettext \
#   && rm -rf /var/cache/apk/*

ENV DOCKERIZE_VERSION v0.3.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

ADD docker-registry.template /etc/nginx/conf.d/docker-registry.template
#RUN envsubst < /etc/nginx/conf.d/mysite.template > /etc/nginx/conf.d/default.conf && nginx'
#RUN echo  '172.17.131.183 artifactory.oss.central1.com' >> /etc/hosts

ENTRYPOINT ["dockerize", "-template", "/etc/nginx/conf.d/docker-registry.template:/etc/nginx/conf.d/docker-registry.conf", "-stdout","/var/log/nginx/access.log","-stderr","/var/log/nginx/error.log","nginx"]
