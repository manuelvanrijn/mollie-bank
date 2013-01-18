# Mollie-Bank [![Gem Version](https://badge.fury.io/rb/mollie-bank.png)][gemversion] [![Build Status](https://secure.travis-ci.org/manuelvanrijn/mollie-bank.png?branch=master)][travis]

[gemversion]: http://badge.fury.io/rb/mollie-bank
[travis]: http://travis-ci.org/manuelvanrijn/mollie-bank

A simple implementation of the "TM Bank" by [Mollie](http://www.mollie.nl), but without the portforward stuff to test your iDeal transactions localy.

![Mollie Bank](http://manuel.manuelles.nl/images/posts/mollie-bank.png) 

## Getting started

### Install

To install the gem you should execute

```
gem install mollie-bank
```

### Running the Mollie Bank

After installation you can simple run:

```
mollie-bank
```

Check if it works by browsing to: [http://localhost:4567/](http://localhost:4567/)

## Howto implement

By default all communication for iDeal transactions is through [https://secure.mollie.nl/xml/ideal](https://secure.mollie.nl/xml/ideal). To use the "Mollie Bank" gem, you have to change this path into [http://localhost:4567/xml/ideal](http://localhost:4567/xml/ideal).

Of course you only want to use this in development mode, so you have to create some code to change this path only when it isn't in production mode.

Check the [Wiki: Implement into existing modules](https://github.com/manuelvanrijn/mollie-bank/wiki/Implement-into-existing-modules) page for implementation of existing frameworks/modules.

## Changelog

A detailed overview of can be found in the [CHANGELOG](https://github.com/manuelvanrijn/mollie-bank/blob/master/CHANGELOG.md).

## Copyright

Copyright © 2012 Manuel van Rijn. See [LICENSE](https://github.com/manuelvanrijn/mollie-bank/blob/master/LICENSE.md) for further details.

[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/c7f118ff9d18b3ec8268969b2c5fff65 "githalytics.com")](http://githalytics.com/manuelvanrijn/mollie-bank)
