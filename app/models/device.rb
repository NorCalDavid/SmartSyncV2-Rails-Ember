class Device < ActiveRecord::Base

  belongs_to :room
  belongs_to :property
  has_one :user, through: :property

  def keys
    [:name, :description, :status, :code, :brand, :devid, :room_id, :property_id]
  end

  def set_status
    devicestatus = {  "Lighting Control" => [["On", 100], ["Off", 101], ["Dim", (0..99).to_a], ["DnD", 102], ["ERR", 502]],
                      "Climate Control" => [["Cool", 600], ["Heat", 651], ["Auto", 625], ["ECO", 626]],
                      "Climate Control - Fan" => [["On", 610], ["Off", 611], ["Idle", 611], ["Auto", 612]],
                      "HVAC/Temp" => (160..1699).to_a,
                      "Motion" => [["Motion-Detected", 901], ["No Motion Detected", 900]],
                      "Security" => [["Armend", 710], ["Disarmed", 711], ["Open", 702], ["Closed", 700]],
                      "Garage" => [["Open", 752], ["Opening", 753], ["Closed", 750], ["Closing", 751], ["Stalled", 755], ["Unknown", 756]]  }
  end

end
