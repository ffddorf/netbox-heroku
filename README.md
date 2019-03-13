# Netbox for Heroku

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

This minimalistic repository allows a simplified deployment of [Netbox](https://github.com/digitalocean/netbox) to [Heroku](https://www.heroku.com/).

It is using the Docker feature recently introduced in Heroku: https://devcenter.heroku.com/articles/build-docker-images-heroku-yml

## Updates

In order to update the Netbox version, set `build.config.VERSION` in `heroku.yml`. This setting determines which tag of the community Netbox docker image to use: https://hub.docker.com/r/netboxcommunity/netbox/tags

## Deployment

**Important:** For this setup to work you have to create a `SECRET_KEY` environment variable in Heroku:

```bash
heroku config:set SECRET_KEY=<long random string>
```

### GitHub

When pushing this to GitHub you can link your repository to Heroku. It will take the `heroku.yml` manifest and build the Docker image.

### GitLab

A `.gitlab-ci.yml` is included for automatic deployment to Heroku.

**Adjustments**
- Set `HEROKU_TARGET` in `vars.yml` to match the name of your Heroku app
- Define `HEROKU_API_KEY` in the CI/CD settings to contain a Heroku API key. [HowTo](https://help.heroku.com/PBGP6IDE/how-should-i-generate-an-api-key-that-allows-me-to-use-the-heroku-platform-api)
