# Sample App

Hartl's *Ruby on Rails Tutorial* chapter 03

#### Takeaways
* Learned some commands for undoing things in Rails. For example:

Undoing controller generation
```
  $ rails generate controller StaticPages home help
  $ rails destroy  controller StaticPages home help
```

Undoing model generation
```
  $ rails generate model User name:string email:string
  $ rails destroy model User
```

Undoing migrations
```
  $ bundle exec rake db:migrate
  $ bundle exec rake db:rollback
  $ bundle exec rake db:migrate VERSION=0
```

* Reviewed how Rails handles GET, POST, PATCH and DELETE
* Learned about how Rails handles classes and inheritance
* Learned about automatically-created tests in the tests/ directory
* Learned how to run tests by using 'rake test' command
* Intro to Test-Driven Development and writing own tests
* Used guard and other gems to improve auto testing
* Learned Ruby language syntax including method definitions
* Used the application_helper module to define helper functions that can be used throughout the whole application
