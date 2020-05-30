# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no.reply.medical.log@gmail.com'
  layout 'mailer'
end
