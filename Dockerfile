FROM ruby:2.5.3

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs

RUN mkdir /medical_log

ENV APP_ROOT /medical_log
WORKDIR /medical_log

ADD ./Gemfile /medical_log/Gemfile
ADD ./Gemfile.lock /medical_log/Gemfile.lock

RUN gem install bundler
RUN bundle install
ADD . /medical_log
