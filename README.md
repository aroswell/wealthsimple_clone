#WealthSimple-Clone#
(written in Ruby, running with Sinatra and Thin)

This app is a knock off of www.wealthsimple.com. It was originally built in Rails but I've decided to use Sinatra and venture beyond some of the Rails magic.

The app is set up to read environment variables for database and secret token from a .dev_env and .test_env file.

For example: (.dev_env or .test_env)
inside the env file
```
 DB_NAME_DEV=database name goes here
 DB_USERNAME=user name
 DB_PASSWORD=password
 SECRET_TOKEN=secret token goes here
```



