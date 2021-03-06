module Operators
  class Service
    def self.rescue_callbacks(*exceptions)
      define_method :call do
        begin
          calling
        rescue *exceptions => error
          failure(error.message)
        end
      end

      define_method :failure_wrapper do |&block|
        begin
          block.call
        rescue *exceptions => error
          failure(error.message)
        end
      end
    end

    rescue_callbacks

    def self.call(*args)
      new(*args).call
    end

    def success(result = nil)
      Dry::Monads.Right(success_wrap(result))
    end

    def failure(result = nil)
      Dry::Monads.Left(error_wrap(result))
    end

    private

    def error_wrap(result)
      result
    end

    def success_wrap(result)
      result
    end

    def calling
      raise 'Not implemented'
    end
  end
end
