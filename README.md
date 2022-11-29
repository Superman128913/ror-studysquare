# StudySquare

## Pull production database to local

    DB=studysquare_development && \
      dropdb $DB; \
      createdb $DB && \
        pg_dump --no-owner --no-privileges $(heroku config:get DATABASE_URL) | \
        psql $DB

## Running application

Be sure to supply the following environment variables to the server process:

* `RACK_ENV` or `RAILS_ENV`: probably `production`

A background worker process must be running as well:

    rake jobs work

## Debugging

### Reading production logs

    heroku logs --tail

## External Services

### Heroku

The application runs on Heroku. Arend, Jetse, Hasher and Pepijn have full access:

https://dashboard.heroku.com/apps/studysquare

#### Configuration settings

Click on `Reveal config vars` to check out all the settings: 

https://dashboard.heroku.com/apps/studysquare/settings

### SMTP server

STMP server for all emails sent from the application: 

https://mandrillapp.com

Ask Marlon for the username/password.

### Incoming email

Managing email accounts and more:

https://s110.webhostingserver.nl:2223 

Ask Marlon for the username/password.

### DNS settings

https://www.cloudflare.com

Ask Pepijn for the username/password.
