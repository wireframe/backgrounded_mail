require 'helper'

class TestBackgroundedMail < Test::Unit::TestCase
  def setup
    Mail.defaults do
      delivery_method :test
    end
  end

  context 'new mail instance' do
    setup do
      @mail = Mail.new
    end
    should 'respond_to mail.deliver_backgrounded' do
      assert @mail.respond_to?(:deliver_backgrounded)
    end
  end

  context 'calling mail.deliver_backgrounded' do
    setup do
      @mail = Mail.new do
        to 'bob@example.com'
        from 'tim@example.com'
      end
      @mail.deliver_backgrounded
    end
    should 'send email via background method' do
      delivery = Mail::TestMailer.deliveries.first
      assert_equal ['bob@example.com'], delivery.to
      assert_equal ['tim@example.com'], delivery.from
    end
  end
end
