class User < ActiveRecord::Base

  has_secure_password
  has_many :properties, dependent: :destroy
  has_many :rooms, through: :properties
  has_many :devices, through: :properties

  validates :email, { :uniqueness => {:case_sensitive => false},
                      :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i} }

  validates :password, :presence => true, length: { minimum: 6 }, confirmation: true

### User Model - Class Methods
###########################################

  def keys
    [:name, :email, :password]
  end

  def counts
    user = User.find(session[:user_id])
    return { homes: user.properties,
             rooms: user.rooms,
             devices: user.devices }
  end

end
