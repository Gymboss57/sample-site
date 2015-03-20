# Middleman Init

Built with [Middleman](http://middlemanapp.com). Read the [docs &rarr;](http://middlemanapp.com/basics/getting-started)

## Requirements

- [Ruby](https://www.ruby-lang.org/en)
- [Bundler](http://bundler.io)

## Get Started

#### Install Gems

```
$ bundle install --path=vendor
```

#### Run Middleman

View the local site at [localhost:4567](http://localhost:4567)

```
$ bundle exec middleman
```

#### Build production site

Generates static site in `/build` directory.

```
$ bundle exec middleman build
```

## Note

If Bower is installed, run:

```
$ bower install
```
#### Bower defaults

- [assets_init](https://github.com/joshfry/assets_init)
  - Replace the contents of `/source/assets/` with `/vendor/bower/assets_init/source`.
- jQuery.js
- Fastclick.js
