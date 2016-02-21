# Sample App

Hartl's *Ruby on Rails Tutorial* chapter 03 through 06

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
* Learned about automatically-created tests in the tests/ directory
* Learned how to run tests by using 'rake test' command
* Intro to Test-Driven Development and writing own tests
* Used guard and other gems to improve auto testing
* Learned Ruby language syntax including method definitions
* Used the application_helper module to define helper functions that can be used throughout the whole application
* Learned about Ruby's own approach to Object Oriented design and inheritance
* Learned about Ruby's Symbol type
* Learned to use Ruby blocks
* Learned how to modify a built-in Ruby class (though this is discouraged, it is indeed possible)
* Learned how to add html partials to the directory structure and load them using the render method
* Learned how to add a custom CSS file to app/assets/stylesheets
* Learned how to use Bootstrap with the bootstrap-sass gem
* Learned about preprocessor engines and how to chain them
* Learned about sass variable and nesting rules
* Learned how to set up a file for integration tests using:

```
  $ rails generate integration_test name_of_new_test_file
```
* Learned about regular expressions and [Rubular](http://www.rubular.com/), a website to check regular expressions
* Learned about using regex to do basic validation of email.

```
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
```
* Learned how to add an index to a database column (for quicker searching like a hash).

Example:
```
$ rails generate migration add_index_to_users_email
```
and in the db/migrate folder, find the migration file and define the change as follows:
```
    add_index :users, :email, unique: true
```
* Learned how to user secure password to the user model
* Learned how to specify which environment you want to work with in console, server, and migrate commands:

```
$ rails console test
```
```
$ rails server --environment production
```
```
bundle exec rake db:migrate RAILS_ENV=production
```
