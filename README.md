# Tilda::Simple::Api
[![Gem Version](https://badge.fury.io/rb/tilda-simple-api.svg)](https://badge.fury.io/rb/tilda-simple-api)
[![Build Status](https://travis-ci.org/gururuby/tilda-simple-api.svg?branch=master)](https://travis-ci.org/gururuby/tilda-simple-api)
[![Maintainability](https://api.codeclimate.com/v1/badges/f9b19b95e9b50be1a52f/maintainability)](https://codeclimate.com/github/gururuby/tilda-simple-api/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/f9b19b95e9b50be1a52f/test_coverage)](https://codeclimate.com/github/gururuby/tilda-simple-api/test_coverage)

Simple ruby wrapper for Tilda API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tilda-simple-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tilda-simple-api

## Usage

Configuration api:

```ruby
  Tilda::Simple::Api.configure do |config|
    config.public_key = "your-public-key"
    config.secret_key = "your-secret-key"
    # config.api_version = "v1" # by default'
    # config.api_host = "http://api.tildacdn.info" # by default'
    # config.raise_api_errors = false # by_default
  end
```

API requests example

### Init API request
```ruby
  tilda_api = Tilda::Simple::Api::Request.new 
  # Or pass public_key and secret_key directly
  tilda_api = Tilda::Simple::Api::Request.new(public_key: "your-public-key", secret_key: "your-secret-key")
```
### API calls

| API Call name                       | Usage                                      | Request/Response example                      |
| ----------------------------------- |------------------------------------------- | --------------------------------------------- |
| **projects list**                   | `tilda_api.projects_list`                  | http://help.tilda.ws/api#getprojectslist      |
| **project by project_id**           | `tilda_api.project(project_id)`            | http://help.tilda.ws/api#getproject           |
| **project info for export**         | `tilda_api.project_export(project_id)`     | http://help.tilda.ws/api#getprojectexport     |
| **pages list for project**          | `tilda_api.pages_list(project_id)`         | http://help.tilda.ws/api#getpageslist         |
| **page by page_id(only body)**      | `tilda_api.page(page_id)`                  | http://help.tilda.ws/api#getpage              |
| **full page by page_id**            | `tilda_api.page_full(page_id)`             | http://help.tilda.ws/api#getpagefull          |
| **page info for export(only body)** | `tilda_api.page_export(page_id)`           | http://help.tilda.ws/api#getpageexport        |
| **full page info for export**       | `tilda_api.page_full_export(page_id)`      | http://help.tilda.ws/api#getpagefullexport    |

### API Errors
When switch `config.raise_api_errors` to `true`. API raise errors. Here is available API Errors:

| API Error                                         | Error case                                      | 
| --------------------------------------------------|-------------------------------------------------|
| **Tilda::Simple::Api::Errors::InvalidCredentials**| invalid public_key or secret_key passed         |
| **Tilda::Simple::Api::Errors::ProjectNotFound**   | tilda api not found project by passed project_id|
| **Tilda::Simple::Api::Errors::PageNotFound**      | tilda api not found page by passed page_id      |
| **Tilda::Simple::Api::Errors::Error**             | in all other cases                              |


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tilda-simple-api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Tilda::Simple::Api project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/tilda-simple-api/blob/master/CODE_OF_CONDUCT.md).
