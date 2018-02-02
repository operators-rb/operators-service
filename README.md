# Operators::Service

[![Gem Version](https://badge.fury.io/rb/operators-service.svg)](https://badge.fury.io/rb/operators-service)
[![CircleCI](https://circleci.com/gh/operators-rb/operators-service.svg?style=shield&circle-token=ce6107feab9a4989e9c8163c6d652bb1bad40cf7)](https://circleci.com/gh/operators-rb/operators-service)
[![Maintainability](https://api.codeclimate.com/v1/badges/3fc7bafea686b44d257f/maintainability)](https://codeclimate.com/github/operators-rb/operators-service/maintainability)

Operators::Service is a lightweight implementation of Service Object based on Either Monad. That gives an home of application business logic.

Service Objects are created when an action:

* Uses integration with external services

* Uses several models

* Is complex (such as calculating sales statistics)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'operators-service'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install operators-service

## Usage

```ruby
class UserCreator < Operators::Service
  attr_reader :params
  
  def initialize(params)
    @params = params
  end

  def call
    user = User.create(params)
    if !user.new_record?
      success(user)
    else
      failure(user.errors)
    end
  end
end
```

`success` - returns instance of `Dry::Monads::Either::Right`

`failure` - returns instance of `Dry::Monads::Either::Left`

```ruby
class UsersController < ApplicationController
  def create
    UserCreator.call(user_params).fmap do |user|
      render json: user
    end.or_fmap do |errors|
      render json: errors.full_messages
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit!
  end
end
```

### More complicated usage

If you need `rescue_callbacks` then you should define `calling` instead of `call`.

```ruby
class Auth < Operators::Service
  rescue_callbacks AuthError, CredentialsError

  def initialize(options)
    @options = options
  end

  def calling
    return failure('User already authed') if @options[:failure] # returns Dry::Monads::Left('User already authed')

    first_auth_transaction
    second_auth_transaction

    success('ok') # returns Dry::Monads::Right('ok')
  end

  private

  def first_auth_transaction
    # do something...
  end

  def second_auth_transaction
    raise AuthError, 'Auth error message' if @options[:auth_error]
  end

  # Wrapper for your error result
  def error_wrap(error)
    error # 'User already authed' || 'Auth error message'
  end

  # Wrapper for your success results
  def success_wrap(success_result)
    success_result # ok
  end
end
```

```ruby
success = Auth.call(email: 'email', password: 'password')
# Dry::Monads::Right('ok')

failure = Auth.call(email: 'email', password: 'password', failure: true)
# Dry::Monads::Left('User already authed')

raised_error = Auth.call(email: 'email', password: 'password', auth_error: true)
# Dry::Monads::Left('Auth error message')
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/operators-rb/operators-service.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
