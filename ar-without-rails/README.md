# Active Record without Rails
Sometimes you want to prototype some functionality. Maybe crawl something some page, or some api, or process some file. And you want a simple data store with the niceties of `ActiveRecord`. But you don't want to create a `Rails` app just for a simple test.

This is a simple script skeleton that adds `Rails/ActiveRecord` functionality.

It adds a `models` and `services` folders that are autoloaded when running the script.

# Usage

* Create the db like in rails with: `rake db:create`. For all the commands: `rake -T`.

* To add models, add the appropriate file inside `models`.

* Add a migration via `rake db:new_migration create_someting`.

* Run the migration with `rake db:migrate`.

* Finally `$ ruby script.rb`.

# TODO

Create a small CLI gem that does this out of the box.

# Installation

```
$ cd ar-without-rails
$ bundle install
```
