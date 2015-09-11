# Seed Database with User Objects

propertynames = ["Primary Residence", "Vacation Home", "Rental Property", "Beach House"]

roomnames = ["Living Room", "Dining Room", "Kitchen", "Entryway", "Hallway", "Garage",
              "Hall Closet", "Half Bath", "Office", "Stairs", "Family Room", "Master Bedroom",
              "Master Bathroom", "Closet", "Guest Bedroom", "Guest Bathroom", "Playroom",
              "Kids Bedroom", "Utility Room", "Backyward", "Patio"]

devicetypes = ["Lighting Control", "Climate Control", "Climate Control - Fan", "HVAC/Temp", "Motion", "Security", "Garage"]

devicenames = { "Lighting Control" => ["Overhead Lights", "Reccessed Lights", "Floor Lamp", "Table Lamp", "Desk Lamp", "Wall Switch"],
                  "Climate Control" => ["HVAC/Mode - Upstairs", "HVAC/Mode - Downstairs"],
                  "Climate Control - Fan" => ["HVAC/Fan - Upstairs", "HVAC/Fan - Downstairs"],
                  "HVAC/Temp" => ["Thermostat - Upstairs", "Thermostat - Downstairs"],
                  "Motion" => ["Motion Sensor", "Motion Sensor"],
                  "Security" => ["Keypad", "Door Sensor", "Window Sensor", "Glass Break Sensor", "Smoke/Heat Detector", "Panic Button"],
                  "Garage" => ["Door 1", "Door 2"] }

devicestatus = { "Lighting Control" => ["On", "Off", "Dim-#{rand(95)+1}%", "DnD"],
                  "Climate Control" => ["Cool", "Heat", "Auto", "ECO"],
                  "Climate Control - Fan" => ["On", "Off", "Idle", "Auto"],
                  "HVAC/Temp" => ["#{rand(80)+1}°"],
                  "Motion" => ["Motion-Detected", "No Motion Detected"],
                  "Security" => ["Armend", "Disarmed", "Open", "Closed"],
                  "Garage" => ["Open", "Opening", "Closed", "Closing", "Stalled", "Unknown"] }

statuscodes = { "Lighting Control" => [["On", 100], ["Off", 101], ["Dim", (0..99).to_a], ["DnD", 102], ["ERR", 502]],
                "Climate Control" => [["Cool", 600], ["Heat", 651], ["Auto", 625], ["ECO", 626]],
                "Climate Control - Fan" => [["On", 610], ["Off", 611], ["Idle", 611], ["Auto", 612]],
                "HVAC/Temp" => (160..1699).to_a,
                "Motion" => [["Motion-Detected", 901], ["No Motion Detected", 900]],
                "Security" => [["Armend", 710], ["Disarmed", 711], ["Open", 702], ["Closed", 700]],
                "Garage" => [["Open", 752], ["Opening", 753], ["Closed", 750], ["Closing", 751], ["Stalled", 755], ["Unknown", 756]] }

15.times do
  password = Faker::Internet.password
  user = User.create({  :name => Faker::Name.name,
                        :email => Faker::Internet.email,
                        :password => password,
                        :password_confirmation => password  })

  (rand(3)+1).times do |count|
    property = Property.create({  :name => propertynames[count-1],
                                  :address => Faker::Address.street_address,
                                  :city => Faker::Address.city,
                                  :state => Faker::Address.state,
                                  :zipcode => Faker::Address.zip  })
    user.properties << property

    (rand(21)+1).times do |count2|
      room = Room.create({ :name => roomnames[count2-1],
                           :description => "#{roomnames[count2-1]} - #{property.name}, #{property.city} #{property.state}" })
      property.rooms << room

      (rand(10)+1).times do
        devicetype = (devicetypes.shuffle[0])

        newdevice = Device.new({ :name => ((devicenames[devicetype]).shuffle)[0],
                                 :status => ((devicestatus[devicetype]).shuffle)[0],
                                 :device_type => devicetype,
                                 :brand => "Insteon" })

        property.devices << newdevice
        room.devices << newdevice
      end
    end
  end
end
