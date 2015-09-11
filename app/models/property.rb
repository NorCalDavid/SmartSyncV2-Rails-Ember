class Property < ActiveRecord::Base

  belongs_to :user
  has_many :rooms, dependent: :destroy
  has_many :devices, dependent: :destroy

  validates :name, :presence => true
  validates :address, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zipcode, :presence => true

  def keys
    [:name, :description, :address, :city, :state, :zipcode]
  end

end
