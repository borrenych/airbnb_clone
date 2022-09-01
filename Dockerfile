FROM ruby:2.7.4

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y yarn

RUN mkdir /app
WORKDIR /app

COPY Gemfile .
COPY Gemfile.lock .

COPY . .

EXPOSE 3000

RUN chmod +x docker.sh
CMD ./docker.sh
