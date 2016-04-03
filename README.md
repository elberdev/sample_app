# Sample App

Hartl's *Ruby on Rails Tutorial* chapter 03 through 11

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
* Learned to change the default configurations for different environments in config/environments.
* Learned how to preview mailer emails by configuring test/mailers/previews/NAME_OF_MAILER_preview.rb
* Learned how to configure SMTP setting for production in config/environments/production.rb
* Learned how to set up production email sending via Heroku's SendGrid free tier.
* Learned how to check environment variables for SendGrid username and password:

```
$ heroku config:get SENDGRID_USERNAME
$ heroku config:get SENDGRID_PASSWORD
```
* Learned to use carrierwave, and fog gems for image uploading.
* With CarrierWave we can generate an image uploader as so:

```
$ rails generate uploader Picture
```
* Learned how to use mini_magick gem for resizing user-uploaded images. mini_magick is a carrierwave interface for image_magick.
* To make sure image_magick is installed on OSX (image_magick should already be installed on Heroku):

```
$ brew install imagemagick
```
* Learned how to configure Heroku environment to work with Amazon Web Services S3 bucket and IAM user credentials, after setting them up on the AWS website:

```
$ heroku config:set S3_ACCESS_KEY=<access key>
$ heroku config:set S3_SECRET_KEY=<secret key>
$ heroku config:set S3_BUCKET=<bucket name>
```
* Learned to set up individual S3 permissions for each user in IAM Management Console (AmazonS3FullAccess)
* Learned to use Ajax for asynchronous server requests that do not leave the page. First, when using the form_for method, add the additional parameter 'remote: true'. Then add the following method to the relevant methods (in this case create and destroy) in the controller to run the javascript code:

```
respond_to do |format|
  format.html { ...stuff... }
  format.js
end
```
The regular html bits are in the braces and the js code is in a separate file (create.js.erb or destroy.js.erb in this example).
