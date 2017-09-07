describe Operators::Service do
  before do
    class TestService < Operators::Service
      rescue_callbacks SyntaxError

      def initialize(data, result)
        @data = data
        @result = result
      end

      def calling
        @result ? success(@data) : failure(@data)
      end

      def except_error(error)
        raise error
      end
    end
  end

  it 'success result' do
    result = TestService.call('data', true)
    expect(result.success?).to be_truthy
  end

  it 'failure result' do
    result = TestService.call('data', false)
    expect(result.success?).to be_falsey
  end

  context 'catch error' do
    subject { TestService.new('error', true) }

    it 'catch' do
      allow(subject).to receive(:calling).and_raise(SyntaxError)

      expect(subject.call.failure?).to be_truthy
    end

    it 'not catch' do
      allow(subject).to receive(:calling).and_raise(LoadError)

      expect { subject.call }.to raise_exception(LoadError)
    end
  end
end
