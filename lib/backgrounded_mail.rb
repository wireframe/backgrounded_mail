require 'mail'
require 'backgrounded'

class Mail::Message
  def deliver_backgrounded
    BackgroundedMailer.deliver_backgrounded self.encoded
  end
end

class BackgroundedMailer
  class << self
    backgrounded :deliver
    def deliver(encoded_mail)
      Mail.new(encoded_mail).deliver
    end
  end
end
