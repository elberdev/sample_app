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
