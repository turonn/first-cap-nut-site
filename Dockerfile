FROM ruby:3.0.3

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /first-cap-nut-site
WORKDIR /first-cap-nut-site
COPY Gemfile /first-cap-nut-site/Gemfile
COPY Gemfile.lock /first-cap-nut-site/Gemfile.lock
RUN bundle install
COPY . /first-cap-nut-site

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]

