#https://github.com/hyperledger/composer/blob/master/packages/composer-rest-server/docker/Dockerfile
FROM hyperledger/composer-rest-server:0.20.4
EXPOSE 3000

ARG VERSION=0.20.4

#https://github.com/hyperledger/composer/blob/master/packages/composer-cli/docker/Dockerfile
USER root
RUN apk add --no-cache make gcc g++ python git libc6-compat && \
        su -c "npm config set prefix '/home/composer/.npm-global'" - composer && \
        su -c "npm install --production -g composer-cli@${VERSION} composer-wallet-redis composer-wallet-cloudant composer-wallet-ibmcos" - composer && \
        su -c "npm cache clean --force" - composer && \
        rm -rf /home/composer/.config /home/composer/.node-gyp /home/composer/.npm && \
        apk del make gcc g++ python git

#pre-req etcd's.sh
RUN apk add --no-cache jq curl

# fornax-composer-rest-server
LABEL maintainer="davimesquita@gmail.com"
ENV ETCD_ENDPOINT http://etcd:2379
ENV FORNAX_CARD basic-sample-network
COPY et.sh /bin/et
COPY etset.sh /bin/etset
COPY etdel.sh /bin/etdel
COPY etfile.sh /bin/etfile
COPY etoutput.sh /bin/etoutput
RUN chmod +x /bin/et
RUN chmod +x /bin/etset
RUN chmod +x /bin/etdel
RUN chmod +x /bin/etfile
RUN chmod +x /bin/etoutput
COPY fornax-rest.sh /bin/fornax-rest
RUN chmod +x /bin/fornax-rest
WORKDIR /home/composer
USER composer
ENTRYPOINT ["/bin/fornax-rest"]
