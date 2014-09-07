# Octopress Quote Tag

An HTML5 blockquote Liquid tag for Jekyll sites.

[![Build Status](https://travis-ci.org/octopress/quote-tag.svg)](https://travis-ci.org/octopress/quote-tag)
[![Gem Version](http://img.shields.io/gem/v/octopress-quote-tag.svg)](https://rubygems.org/gems/octopress-quote-tag)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://octopress.mit-license.org)

## Installation

Add this line to your application's Gemfile:

    gem 'octopress-quote-tag'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install octopress-quote-tag

Next add it to your gems list in Jekyll's `_config.yml`

    gems:
      - octopress-quote-tag

## Usage

```
{% blockquote [options] %}
Some great quote
{% endblockquote %}
```

Options:

| option | default | description |
|:-------|:--------|:------------|
| author | nil     | String: Quote author |
| title  | nil     | String: Title of work cited |
| url    | nil     | String: Link to work |


### Example

```
{% quote author:"Bob McAwesome" url:"http://example.com" title:"Great Wisdom" %} 
Never pet a burning dog.
{% endquote %}
```

```
<figure class='quote'>
  <blockquote>
    <p>Some great quote</p>
  </blockquote>
  <figcaption class='quote-source'>
    <span class='quote-author'>Bob McAwesome</span>
    <cite class='quote-title'><a href='http://example.com'>Great Wisdom</a></cite>
  </figcaption>
</figure>
```

## Why?

In Markdown Blockquotes are simple but attribution isn't.
Also, if you want semantic HTML, you'll have to write your own.

```
> Some cool quote

# becomes:

<blockquote>
  <p>Some cool quote</p>
</blockquote>
```

But what if you want to cite an author or a source?


```
> Some cool quote
> - Bob McAwesome

# becomes:

<blockquote>
  <p>Some cool quote
- Bob McAwesome</p>
</blockquote>
```

Which doesn't work at all since a browser will see it as:

```
Some cool quote - Bob McAwesome
```
