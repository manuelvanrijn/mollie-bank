# Mollie-Bank

A simple implementation of the "TM Bank" by Mollie, but without the portforward stuff to test your iDeal transactions localy.

## Install and Run it

Install the gem

```
gem install mollie-bank
```

Run the mollie-bank

```
mollie-bank
```

Check if it works by browsing to: [http://localhost:4567/](http://localhost:4567/)

## Howto implement

Here's a list with examples how to use this gem in combination with some API/Frameworks I found/used. Feel free to extend this list with your examples.

### Ruby on Rails

Add the `mollie-bank` to your Gemfile

```
gem 'mollie-bank', :git => 'https://github.com/manuelvanrijn/mollie-bank.git'
```

Change you config.ru so it will run the mollie-bank when you start the rails server. For example, I changed the following:

```
# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run YourRailsApplicationName::Application
```

into:

```
# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
require 'mollie-bank'

# - Make sinatra play nice
use Rack::MethodOverride
disable :run, :reload

map "/" do
  run YourRailsApplicationName::Application
end

configure(:development) {
  map "/mollie-bank" do
    run MollieBank::Application
  end
}
```

At this point you must communicate with [http://localhost:3000/mollie-bank/xml/ideal](http://localhost:3000/mollie-bank/xml/ideal) instead of the official [https://secure.mollie.nl/xml/ideal](https://secure.mollie.nl/xml/ideal)

#### Use the ideal-mollie gem

If you are using the [ideal-mollie](https://github.com/manuelvanrijn/ideal-mollie) gem, you can easely implement this by changing / adding two lines to you `config.ru`

```
configure(:development) {
  map "/mollie-bank" do
    IdealMollie.send(:remove_const, 'MOLLIE_URL')
    IdealMollie.const_set('MOLLIE_URL', 'http://localhost:3000/mollie-bank/xml/ideal')
    run MollieBank::Application
  end
}
```
