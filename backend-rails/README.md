# Batos Jugando Webapp Tools

Some tools to make life easier to all on Batos Jugando, this is the web app that handles everything

## Currently doing:
- Automate `El Hongo Verde` publish process
- Twitter reader to check the `BatosJugando` account and post `#discord` tweets to the Discord Server
- Discord Bot for... stuff?
- ?? 
- PROFIT!

## Development

* Ruby version: `2.6.5`
> Recommended to use: [rbenv](https://github.com/rbenv/rbenv) to handle ruby versions.

* System dependencies (See `Gemfile`)

## Configuration

See the `env.example` file to fill the environment variables, also the secrets file is working with production
 credentials just in case... ask for the private key to change those.

### Database creation
Just install Postgresql latest version.

### Database initialization
As simple as `bundle install rails db:create`

### How to run the test suite
`RSpec`

### Services (job queues, cache servers, search engines, etc.)
run `Sidekiq` and that's it.

### Deployment instructions
Capistrano makes everything, it sends everything to `digital ocean` to the `otfusion` server,
 you just require SSH access.


## 3rd party stuff

### Reddit
I created a dev app for Reddit but you can use your own, go to: https://www.reddit.com/prefs/apps

The redirect site for the test (added on credentials) is `http://localhost:3000/reddit/redirect`

