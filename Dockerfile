FROM ruby:2.5.3

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs npm && npm install -g n && \
        n stable && \
        npm install -g yarn

RUN apt install -y chrpath libssl-dev libxft-dev
RUN apt install -y libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev
ADD https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /usr/local/share/
RUN ln -sf /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin

RUN mkdir /medical_log

ENV APP_ROOT /medical_log
WORKDIR /medical_log

COPY ./Gemfile /medical_log/Gemfile
COPY ./Gemfile.lock /medical_log/Gemfile.lock

RUN gem install bundler
RUN bundle install
ADD . /medical_log
