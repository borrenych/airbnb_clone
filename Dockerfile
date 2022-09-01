FROM ruby:2.7.0

RUN mkdir /app
WORKDIR /app

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

COPY . .

EXPOSE 3000

RUN chmod +x docker.sh
CMD ./docker.sh
