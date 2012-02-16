# Mollie-Bank

A simple implementation of the "TM Bank" by [Mollie](http://www.mollie.nl), but without the portforward stuff to test your iDeal transactions localy.

## Getting started

### Install

To install the gem you should execute

```
gem install mollie-bank
```

Or if you are implementing this into a Rails project you could add the gem into your `Gemfile`.

```
gem 'mollie-bank'
```

Finally, if you don’t dig any of that gemming that’s so popular nowadays, you can install it as a plugin for you Rails project:

```
cd vendor/plugins
git clone --depth 1 git://github.com/manuelvanrijn/mollie-bank.git mollie-bank
```

### Running the Mollie Bank

After installation you can simple run:

```
mollie-bank
```

Check if it works by browsing to: [http://localhost:4567/](http://localhost:4567/)

## Howto implement

By default all communication for iDeal transactions is through [https://secure.mollie.nl/xml/ideal](https://secure.mollie.nl/xml/ideal). To use the "Mollie Bank" gem, you have to change this path into http://localhost:4567/xml/ideal](http://localhost:4567/xml/ideal).

Of course you only want to use this in development mode, so you have to create some code to change this path only when it isn't in production mode.

Check the [Wiki: Implement into existing modules](https://github.com/manuelvanrijn/mollie-bank/wiki/Implement-into-existing-modules) page for implementation of existing frameworks/modules.

## Changelog

A detailed overview of can be found in the [CHANGELOG](https://github.com/manuelvanrijn/mollie-bank/blob/master/CHANGELOG.md).

## Copyright

Copyright © 2012 Manuel van Rijn. See [LICENSE](https://github.com/manuelvanrijn/mollie-bank/blob/master/LICENSE.md) for further details.
