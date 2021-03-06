FROM strawpay/ansible-java


RUN apt-get update && apt-get install -y \
    build-essential libssl-dev \
 && rm -rf /var/lib/apt/lists/* 

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.9.4

WORKDIR $NVM_DIR

RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && npm install -g grunt \
    && npm install -g bower

COPY ./import-letsencrypt.sh /tmp/import-letsencrypt.sh

ENV JAVA_HOME=/usr/lib/jvm/java-8-oracle/

RUN chmod +x /tmp/import-letsencrypt.sh \
&& /tmp/import-letsencrypt.sh \
&& rm /tmp/import-letsencrypt.sh

WORKDIR /