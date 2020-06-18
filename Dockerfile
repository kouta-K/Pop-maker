FROM ruby:2.6.3

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs

RUN mkdir /myapp

WORKDIR /myapp

ENV APP_ROOT /myapp

COPY ./Gemfile $APP_ROOT/Gemfile

COPY ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle install

COPY ./ APP_ROOT

EXPOSE 3000

CMD ["rails", "s"]
