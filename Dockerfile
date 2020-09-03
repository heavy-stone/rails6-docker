FROM ruby:2.7.1

    # Yarn v1.22.5(Stable Version as of 20200904)
    # https://qiita.com/FumiyaShibusawa/items/627f0c806b49e364c3db
RUN wget https://github.com/yarnpkg/yarn/releases/download/v1.22.5/yarn_1.22.5_all.deb \
    && dpkg -i yarn_1.22.5_all.deb \
    && rm yarn_1.22.5_all.deb \
    # Node.js v12.x (LTS version as of 20200903)
    # https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    # Install packages
    && apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
