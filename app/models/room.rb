class Room < ActiveRecord::Base
  belongs_to :property
  has_many :devices

  def keys
    [:name, :description]
  end
end
