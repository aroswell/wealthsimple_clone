#WealthSimple-Clone#
(written in Ruby, running with Sinatra and Thin)

This app is a knock off of www.wealthsimple.com. It was originally built in Rails but I've decided to use Sinatra and venture beyond some of the Rails magic.

###Configuration:
The app is set up to read environment variables for database and secret token from a .dev_env and .test_env file.

For example: (inside the .dev_env or .test_env)
```
 DB_NAME_DEV=database name goes here
 DB_USERNAME=user name
 DB_PASSWORD=password
 SECRET_TOKEN=secret token goes here
```

###Running the App:
Simply run the rake task `$: rake app:run`

###Test Specs:
See the ./spec folder details on Rspec testing specs

###Other features:
To list all rake task: `$: rake -T`

Some rake task allow you to pass in an environment variable (e.g. test) when reseting a database.


