# def location_params
#   addrs = []
#   addrs << {address: "182 Shipley St",    city: "San Francisco", state: "CA", zip: 94107}
#   addrs << {address: "230 California St", city: "San Francisco", state: "CA", zip: 94111}
#   addrs << {address: "999 Green St",      city: "San Francisco", state: "CA", zip: 94133}
#   addrs << {address: "844 Lombard St",    city: "San Francisco", state: "CA", zip: 94133}
#   addrs << {address: "1491 27th Ave",     city: "San Francisco", state: "CA", zip: 94122}
#   addrs << {address: "1315 38th Ave",     city: "San Francisco", state: "CA", zip: 94122}
#   addrs << {address: "2543 Pacheco St",   city: "San Francisco", state: "CA", zip: 94122}
#   addrs << {address: "1684 18th Ave",     city: "San Francisco", state: "CA", zip: 94122}
#   addrs << {address: "527 Moraga St",     city: "San Francisco", state: "CA", zip: 94122}
#   addrs << {address: "119 10th Ave",      city: "San Mateo", state: "CA", zip: 94401}
#   addrs << {address: "621 S Grant St",    city: "San Mateo", state: "CA", zip: 94402}
#   addrs << {address: "229 Castilian Way", city: "San Mateo", state: "CA", zip: 94402}
#   addrs << {address: "1201 Maple St",     city: "San Mateo", state: "CA", zip: 94402}
#   addrs << {address: "930 S Grant St",    city: "San Mateo", state: "CA", zip: 94402}
#   addrs << {address: "2817 Chestnut St",  city: "Oakland", state: "CA", zip: 94608}
#   addrs << {address: "3233 West St",      city: "Oakland", state: "CA", zip: 94608}
#   addrs << {address: "5926 Whitney St",   city: "Oakland", state: "CA", zip: 94609}
#   addrs << {address: "564 63rd St",       city: "Oakland", state: "CA", zip: 94609}
#   addrs << {address: "566 57th St",       city: "Oakland", state: "CA", zip: 94609}
#   addrs << {address: "4839 Webster St",   city: "Oakland", state: "CA", zip: 94609}
#   addr = addrs.sample
#   {
#     address: addr[:address], 
#     city: addr[:city],
#     state:  addr[:state],
#     zip:   addr[:zip],
#     school_name: Faker::Company.name
#   }
# end

def zip_sample
  [94107, 94111, 94133, 94122, 94401, 94402, 94608, 94609].sample
end

def user_params
  {
    preferred_email: Faker::Internet.email,
    password: '1234567890',
    name: Faker::Name.name,
    teacher: [true, false].sample,
  }
end

def flip
  [true, false].sample
end

zac = User.register({ preferred_email: 'zacmitton22@gmail.com', password: '1234567890', name: 'zac', teacher: false }, {}).save

5.times do
  u = User.register(user_params, {})
  u.save
  rand(0..2).times do
    Listing.create(
      subject: Faker::Lorem.sentence(rand(2..7)), 
      body: Faker::Lorem.paragraph(rand(2..7)), 
      buying: false, 
      selling: flip, 
      lending: flip, 
      trading: flip, 
      borrowing: false,
      author_id: u.id, 
      active: true,
      zip: zip_sample
    )
  end
end


  # def user_params
  #   params[:user].permit(:preferred_email, :password, :name, :teacher, :image_path, :location_attributes)
  # end

  # def location_params
  #   params[:user][:location_attributes].permit(:address, :city, :state, :zip, :school_name)
  # end
