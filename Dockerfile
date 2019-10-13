FROM alpine:3.7
RUN apk update && apk upgrade
RUN apk add chromium wget curl openssh-client openjdk8-jre php7 php7-curl php7-zip php7-phar php7-openssl php7-mbstring php7-json php7-xml
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN wget https://chromedriver.storage.googleapis.com/2.38/chromedriver_linux64.zip -P ~/
RUN unzip ~/chromedriver_linux64.zip -d ~/
RUN rm ~/chromedriver_linux64.zip
RUN mv -f ~/chromedriver /usr/bin/chromedriver
RUN adduser -SD chromium && addgroup -S chromium
RUN chown chromium:chromium /usr/bin/chromedriver
RUN chmod 0755 /usr/bin/chromedriver

ENV MAVEN_VERSION 3.5.4
ENV MAVEN_HOME /usr/lib/mvn
ENV PATH $MAVEN_HOME/bin:$PATH

RUN wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  mv apache-maven-$MAVEN_VERSION /usr/lib/mvn
