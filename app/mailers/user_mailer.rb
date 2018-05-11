class UserMailer < ActionMailer::Base
  default from: "YoungVarsity<team@youngvarsity.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.contact_reply.subject
  #

  def contact_reply (message, firtsname)
    @greeting = "Hey"
    @message = message
    @firtsname = firtsname
    mail to: @message.email
    mail subject: "Thanks #{firtsname} for contacting Youngvarsity!"
  end

  def contact_us (message)
    @message = message
    mail subject: "From the Contact us form"
    mail from: message.email
    mail to: "YoungVarsity<team@youngvarsity.com>"
  end

  def incoming_invite_req(email)
    @email = email
    mail subject: "Invite request notif"
    mail from: email
    mail to: "YoungVarsity<team@youngvarsity.com>"
  end

  def incoming_invitation(email)
    @email = email
    mail subject: "We've received your invitation request"
    mail from: "YoungVarsity<team@youngvarsity.com>"
    mail to: email
  end

  def card_print_order (user, order_type)
    if order_type == "order"
      mail subject: "Print order received"
    else
      mail subject: "Print order CANCELED"
    end
    @username = "#{user.firstname} #{user.lastname}"
    mail to: "<didier.uzan@gmail.com>"
  end
end
