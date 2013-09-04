class AddAdminUser < ActiveRecord::Migration
  def self.up
    User.create(:name                  => 'figura4',
                :homepage              => 'http:\\figura4.com',
                :email                 => 'webmaster@figura4.com',
                :is_admin              => true,
                :is_editor             => true,
                :password              => 'sh1r0w76!',
                :password_confirmation => 'sh1r0w76!')
  end

  def self.down
    User.find_by_name('figura4').destroy if User.find_by_name('figura4')
  end
end
