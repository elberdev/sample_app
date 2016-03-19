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
* Learned how to add secure password to the user model
* Learned how to specify which environment you want to work with in console, server, and migrate commands:

```
$ rails console test
```
```
$ rails server --environment production
```
```
$ bundle exec rake db:migrate RAILS_ENV=production
```
* Learned how to use the Byebug gem to create breakpoints and a debugging environment while running an app in the Rails server by simply adding the word 'debugger' to the Ruby code where I want the breakpoint to kick in.
* Learned how to reset the database:

```
$ bundle exec rake db:migrate:reset
```
* Learned how to enable SSL in production environment by uncommenting the following line in config/environments/production.rb:

```
config.force_ssl = true
```
* Learned how to configure a Puma server on Heroku by adding the puma gem to the Gemfile in production, and by creating a config/puma.rb file with content described in Heroku's documentation.
* Learned how to use Rails' 'session' method to create a temporary cookie for identification purposes. This cookie is automatically deleted when the browser is closed.
* Learned about the ||= (or equals) operator in Ruby. It can be used for example to assign a value only if the variable is currently nil:

```
@current_user = @current_user || User.find_by(id: session[:user_id])
```
can be written as:

```
@current_user ||= User.find_by(id: session[:user_id])
```
based on the principle of short-circuit evaluation.
* Learned to use attr_accessor to set up writer and reader (setter and getter) methods for an instance variable.
* Learned how to fix last commit message using:

```
$ git commit --amend
```
* Learned to user Heroku's maintenance mode while pushing changes to website, doing migrations. Example:

```
$ heroku maintenance:on
$ git push heroku
$ heroku run rake db:migrate
$ heroku maintenance:off
```

* Learned how to define class methods multiple ways. Example:

```
def User.new_token
  # do stuff
end
```
```
def self.new_token
  # do stuff
end
```
```
class << self
  def new_token
    # do stuff
  end
end
```
* Learned how to access instance variables and their attributes from other classes inside tests using the assigns() method. The assigns method is a hash that gives access in a test to all instance variables that would ordinarily be available to a view. Calling @user.remember_token in our integration users_login_test.rb would return nil, but calling assigns(:user).remember_token returns the value we are looking for.
* Learned how to use Faker gem to add users for the development environment.
* Learned how to reset the database locally and on Heroku:

```
$ bundle exec rake db:migrate:reset
```
```
$ heroku pg:reset DATABASE
```
* Learned how to seed the database using db/seeds.rb and the local and Heroku commands:

```
$ bundle exec rake db:seed
```
```
$ heroku run rake db:seed
```
* Learned to use a pagination method in Rails to break up information across multiple pages by including the gem 'will_paginate' and its bootstrap configuration 'bootstrap-will_paginate'
* Learned how to generate mailers in Rails. A mailer adds email functionality to our app/site. As an example, this is the creation of a mailer with a method for account activation and a method for password reset:

```
$ rails generate mailer UserMailer account_activation password_reset
```
This command will also generate two views for each method. One view for plain text email and another for html emails.
