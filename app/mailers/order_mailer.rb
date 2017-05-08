class OrderMailer < ApplicationMailer

  def mail_order order
    @greeting = t "mail.hi"
    @order = order
    mail to: "food.drind.framgia@gmail.com"
  end
end
