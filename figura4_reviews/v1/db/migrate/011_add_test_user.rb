class AddTestUser < ActiveRecord::Migration
  def self.up
    user = User.create(:name => 'figura4',
                       :password => 'sh1r0w76!',
                       :password_confirmation => 'sh1r0w76!',
                       :email => 'figura4@tin.it',
                       :homepage => 'www.figura4.com')
    user.save
  end

  def self.down
    User.delete_all
  end
end
