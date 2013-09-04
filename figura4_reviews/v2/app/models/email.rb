class Email < ActiveRecord::Base
  validates_presence_of :sender, :sender_address, :is_spam, :body
end
