FROM ruby:2.7.2

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt install -y nodejs

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn

# Set paths
ENV APP_HOME /application
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Set timezone
ENV TZ America/Sao_Paulo

# Copy dependencies data
COPY package.json yarn.lock Gemfile Gemfile.lock ./

# Install dependencies
RUN bundle install
RUN yarn install

# Copy project
COPY . $APP_HOME

# Expose port used by the application
EXPOSE 3000

# Start script
CMD sh scripts/start_rails.sh