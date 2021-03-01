# 20210226

# Ruby 2.7.2(Stable Version)
# https://www.ruby-lang.org/ja/downloads/
FROM ruby:2.7.2

# Yarn v1.22.10(Stable Version) https://github.com/yarnpkg/yarn/releases
# https://qiita.com/FumiyaShibusawa/items/627f0c806b49e364c3db
RUN wget https://github.com/yarnpkg/yarn/releases/download/v1.22.10/yarn_1.22.10_all.deb \
    && dpkg -i yarn_1.22.10_all.deb \
    && rm yarn_1.22.10_all.deb \
    # Node.js v14.x (LTS version)
    # https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions
    && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    # Install packages
    && apt-get update -qq && apt-get install -y nodejs

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
