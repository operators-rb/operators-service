# Operators::Service

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
class Auth < Operators::Service
  rescue_callbacks AuthError, CredentialsError

  def initialize(credentials)
    @options = options
  end

  def calling
    return failure('User already authed') if @options[:failure] # returns Dry::Monada::Left('User already authed')

    first_auth_transaction
    second_auth_transaction

    success('ok') # returns Dry::Monada::Right('ok')
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
# Dry::Monada::Right('ok')

failure = Auth.call(email: 'email', password: 'password', failure: true)
# Dry::Monada::Left('User already authed')

raised_error = Auth.call(email: 'email', password: 'password', auth_error: true)
# Dry::Monada::Left('Auth error message')
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/operators-rb/operators-service.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
