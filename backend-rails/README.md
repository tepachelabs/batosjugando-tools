# Batos Jugando Webapp Tools

Web App and API to make life easier for the community of Batos Jugando.

## Current Features:
- Automate `El Hongo Verde` publish process
- Twitter reader to check the `BatosJugando` account and post `#discord` tweets to the Discord Server
- ??
- PROFIT!

## Requirements

* Ruby version: `2.6.5`
  > Recommended to use: [rbenv](https://github.com/rbenv/rbenv) to handle ruby versions.
* Database: `PostgreSQL`
* System dependencies (See `Gemfile`)

## Development

## Configuration

- There are a few environment variables used in the project, 
 see `env.example` file to fill the environment variables when required.

### Secrets
- The secrets file is working with production
 credentials.
- Add a issue in order to add a new secret with the production values correctly.

### Database creation
As simple as `bundle install rails db:create`

### Database initialization
As simple as `bundle install rails db:seed`, the main user is `admin@otfusion.org` and password is simply: `password`.

### How to run the test suite
Run `rspec` in this directory.

### Services (job queues, cache servers, search engines, etc.)
As simple as `bundle exec sidekiq`

## Deployment
- Currently we are using capistrano to deploy the production environment (single env),
- SSH access is required

In order to deploy this product, you require all the


## 3rd party information

### Reddit
- Credentials already present for development.
- In order to create your own secrets file to test, go to: https://www.reddit.com/prefs/apps
- The redirect site for the test (added on credentials) is `http://localhost:3001/reddit/redirect`

