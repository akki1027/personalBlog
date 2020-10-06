FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /personalBlog
WORKDIR /personalBlog
COPY Gemfile /personalBlog/Gemfile
COPY Gemfile.lock /personalBlog/Gemfile.lock
RUN gem install bundler -v 2.1.4
RUN gem install rails -v 6.0.3.3
RUN bundle install
COPY . /personalBlog

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
