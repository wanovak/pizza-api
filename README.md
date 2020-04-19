# pizza-api
simple rack app using grape and angular

## Set-up
1. Ensure Postgres is installed and running
2. Create user if none existing
```
create user pizza with password 'pizza';
```
3. Create dev and test databases
```
create database pizza_development;
create database pizza_test;
```
4. Grant privileges of user from step #2 to databases in step #3
```
grant all privileges on database pizza_development to pizza;
grant all privileges on database pizza_test to pizza;
```
5. Export your Postgres user/password as environment variables
```
export PGSQL_USER=pizza
export PGSQL_PW=pizza
export PGSQL_DB=pizza
```
6. Bundle and create and seed tables
```
bundle install
rake db:create
rake db:seed
```

## Run
1. `rackup`
