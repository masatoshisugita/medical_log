FROM ruby:2.5.3

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs

RUN mkdir /medical_log

ENV APP_ROOT /medical_log
WORKDIR /medical_log

COPY ./Gemfile /medical_log/Gemfile
COPY ./Gemfile.lock /medical_log/Gemfile.lock

RUN gem install bundler
RUN bundle install
ADD . /medical_log
