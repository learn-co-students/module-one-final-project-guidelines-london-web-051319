require 'faker'

Artist.delete_all
Venue.delete_all
Concert.delete_all
User.delete_all
Ticket.delete_all 

muse = Artist.create(name: "Muse", genre: "rock", website_url: "https://www.muse.mu", email: "muse@muse.mu", password: "we_rock!")
aerosmith = Artist.create(name: "Aerosmith", genre: "rock", website_url: "https://www.aerosmith.com/welcome", email: "smitty@aerosmith.com", password: "sdr&R")
lso = Artist.create(name: "London Symphony Orchestra", genre: "classical", website_url: "https://lso.co.uk", email: "classical@lso.co.uk", password: "we'reClassical")
fonsi = Artist.create(name: "Luis Fonsi", genre: "pop", website_url: "https://www.luisfonsi.com", email: "amor@fonzi.pr", password: "all_the_Love")
jones = Artist.create(name: "Tom Jones", genre: "pop", website_url: "https://www.tomjones.com", email: "jonesy@tomjones.com", password: "not_unusual")
metallica = Artist.create(name: "Metallica", genre: "rock", website_url: "https://www.metallica.com", email: "metallicats@metallica.com", password: "whisky")
lenny = Artist.create(name: "Lenny Kravitz", genre: "rock", website_url: "http://www.lennykravitz.com", email: "len@kravitz.com", password: "good_vibes")
spice = Artist.create(name: "Spice Girls", genre: "pop", website_url: "https://www.thespicegirls.com", email: "power@spiceworld.com", password: "spice up yer life")
bill = Artist.create(name: "Bill Bailey", genre: "alternative", website_url: "https://billbailey.co.uk", email: "billy@bailey.com", password: "wonderfunk")

91.times{Artist.create(name: Faker::Music.band, genre: Faker::Music.genre, website_url: Faker::Internet.url, email: Faker::Internet.unique.email, password: Faker::Internet.password(8))}
#100 artists total

o2 = Venue.create(name: "O2 Arena", website_url: "https://www.theo2.co.uk", location: "London, UK", facilities: ["bars", "restaurants", "bathrooms", "disabled access"], email: "02@arenauk.com", password: "we're_big", capacity: 60000)
nec = Venue.create(name: "NEC", website_url: "http://www.thenec.co.uk/whats-on/", location: "Birmingham, UK", facilities: ["bars", "restaurants", "bathrooms", "disabled access"], email: "nec@midlands.co.uk", password: "expo", capacity: 40000)
symphony = Venue.create(name: "Symphony Hall", website_url: "https://www.thsh.co.uk", location: "Birmingham, UK", facilities: ["bathrooms", "disabled access", "art gallery", "cloakroom"], email: "symphony@classical.co.uk", password: "acoustics", capacity: 6500)
albert = Venue.create(name: "Royal Albert Hall", website_url: "https://www.royalalberthall.com", location: "London, UK", facilities: ["bathrooms", "disabled access"], email: "alby@royalalbert.com", password: "princealbert", capacity: 5000)
wembley = Venue.create(name: "Wembley Stadium", website_url: "http://www.wembleystadium.com", location: "London, UK", facilities: ["bars", "restaurants", "bathrooms", "disabled access"], email: "wembley@statdiumsuk.co.uk", password: "national_pride_apparently", capacity: 90000)
manchester = Venue.create(name: "Manchester Arena", website_url: "http://www.manchester-arena.com", location: "Manchester, UK", facilities: ["bars", "restaurants", "bathrooms", "disabled access"], email: "manc@arenasuk.co.uk", password: "always_raining", capacity: 35000)
o2_newc = Venue.create(name: "O2 Academy Newcastle", website_url: "https://academymusicgroup.com/o2academynewcastle/", location: "Newcastle, UK", facilities: ["bars", "bathrooms", "disabled access"], email: "02_newc@arenauk.com", password: "waiai*", capacity: 20500)
rock = Venue.create(name: "Rock City", website_url: "https://www.rock-city.co.uk", location: "Nottingham, UK", facilities: ["bars", "bathrooms"], email: "notts@thecity.co.uk", password: "rockon", capacity: 40000)

12.times{Venue.create(name: Faker::WorldCup.stadium, website_url: Faker::Internet.url,location: Faker::WorldCup.city, facilities: [Faker::Appliance.equipment, Faker::Appliance.equipment, Faker::Appliance.equipment], email: Faker::Internet.email, password: Faker::Internet.password(8), capacity: rand(90000))}
#20 venues total

user1 = User.create(name: "Bobby Harrisson", dob: "1977-08-28", card_1_number: rand(1...10000000000000000), email: "bob@fmail.com", password: "bob")
user2 = User.create(name: "Claire Redbridge", dob: "1995-01-31", card_1_number: rand(1...10000000000000000), email: "claire@atlook.com", password: "WJAs7d8")
user3 = User.create(name: "Asim Qurashee", dob: "1999-05-14", card_1_number: rand(1...10000000000000000), email: "qshi@wahoo.co.uk", password: "cueball")
user4 = User.create(name: "Sophia Mensheviska", dob: "1988-10-07", card_1_number: rand(1...10000000000000000), email: "soph67@fmail.com", password: "rooter")
user5 = User.create(name: "Lena Orgolova", dob: "1986-11-11", card_1_number: rand(1...10000000000000000), email: "lena@rumail.com", password: "A&S(d7h")
user6 = User.create(name: "Sam Gamgee", dob: "1992-05-27", card_1_number: rand(1...10000000000000000), email: "mrfrodo@middleearth.net", password: "precious")
user7 = User.create(name: "Alex Ramsay", dob: "1994-08-27", card_1_number: rand(1...10000000000000000), email: "ramsaaay@fmail.com", password: "SKDHJoa7")
user8 = User.create(name: "Mo Farrar", dob: "2000-09-30", card_1_number: rand(1...10000000000000000), email: "mozy@fmail.com", password: "sdlhasD#")

992.times{User.create(name: Faker::Name.name, dob: Faker::Date.between(80.years.ago, 18.years.ago), card_1_number: rand(1...10000000000000000), email: Faker::Internet.unique.email, password: Faker::Internet.password(8))}
#1000 customers

concert1 = Concert.create(name: "Fractured Future Tour: London", price: 60.00, date: "2019-06-04", website_url: "TBC", artist_id: muse.id, venue_id: o2.id)
concert2 = Concert.create(name: "Lovin' it up 2019", price: 75.00, date: "2019-10-02", website_url: "TBC", artist_id: aerosmith.id, venue_id: wembley.id)
concert3 = Concert.create(name: "Summer Nights", price: 40.00, date: "2020-01-16", website_url: "TBC", artist_id: lso.id, venue_id: albert.id)
concert4 = Concert.create(name: "Despacito", price: 35.00, date: "2019-07-01", website_url: "TBC", artist_id: fonsi.id, venue_id: manchester.id)
concert5 = Concert.create(name: "Green Grass Tour: Birmingham", price: 65.00, date: "2021-01-04", website_url: "TBC", artist_id: jones.id, venue_id: nec.id)
concert6 = Concert.create(name: "Metallicats", price: 60.00, date: "2021-05-30", website_url: "TBC", artist_id: metallica.id, venue_id: o2.id)
concert7 = Concert.create(name: "Raise Vibrations", price: 50.00, date: "2019-11-04", website_url: "TBC", artist_id: lenny.id, venue_id: o2_newc.id)
concert8 = Concert.create(name: "Spice It Up!", price: 120.00, date: "2019-12-20", website_url: "TBC", artist_id: spice.id, venue_id: nec.id)
concert9 = Concert.create(name: "Mindgoogling: London", price: 70.00, date: "2019-07-14", website_url: "TBC", artist_id: bill.id, venue_id: albert.id)
concert10 = Concert.create(name: "Fractured Future Tour: Newcastle", price: 60.00, date: "2019-10-04", website_url: "TBC", artist_id: muse.id, venue_id: o2_newc.id)
concert11 = Concert.create(name: "Fractured Future Tour: Manchester", price: 60.00, date: "2019-06-15", website_url: "TBC", artist_id: muse.id, venue_id: manchester.id)
concert12 = Concert.create(name: "Fractured Future Tour: Nottingham", price: 60.00, date: "2019-11-01", website_url: "TBC", artist_id: muse.id, venue_id: rock.id)
concert13 = Concert.create(name: "Fractured Future Tour: Wembley", price: 90.00, date: "2019-10-30", website_url: "TBC", artist_id: muse.id, venue_id: wembley.id)
concert14 = Concert.create(name: "Green Grass Tour: Manchester", price: 65, date: "2019-10-20", website_url: "TBC", artist_id: jones.id, venue_id: manchester.id)
concert15 = Concert.create(name: "Green Grass Tour: London", price: 100, date: "2019-10-16", website_url: "TBC", artist_id: jones.id, venue_id: wembley.id)
concert16 = Concert.create(name: "Oh no!", price: 40, date: "2019-12-13", website_url: "TBC", artist_id: fonsi.id, venue_id: nec.id)
concert17 = Concert.create(name: "Mindgoogling: Newcastle", price: 70, date: "2020-11-07", website_url: "TBC", artist_id: bill.id, venue_id: o2_newc.id)
concert18 = Concert.create(name: "Spice Up Your Life: Manchester", price: 90, date: "2019-07-31", website_url: "TBC", artist_id: spice.id, venue_id: manchester.id)
concert19 = Concert.create(name: "Spice Up Your Life: Newcastle", price: 90, date: "2019-12-01", website_url: "TBC", artist_id: spice.id, venue_id: o2_newc.id)
concert20 = Concert.create(name: "Good Vibrations", price: 60, date: "2019-11-13", website_url: "TBC", artist_id: lenny.id, venue_id: o2.id)

#20 concerts
a = Artist.all.first.id
z = Artist.all.last.id

aa = Venue.all.first.id
zz = Venue.all.last.id

30.times{Concert.create(name: Faker::Verb.ing_form+" "+Faker::Verb.past_participle+" "+Faker::Verb.base, price: Faker::Commerce.price, date: Faker::Date.unique.between(Date.today, 2.years.from_now), website_url: Faker::Internet.url, artist_id: rand(a..z), venue_id: rand(aa..zz))}

ticket1 = Ticket.create(user_id: user1.id, concert_id: concert1.id)
ticket2 = Ticket.create(user_id: user2.id, concert_id: concert5.id)
ticket3 = Ticket.create(user_id: user3.id, concert_id: concert3.id)
ticket4 = Ticket.create(user_id: user4.id, concert_id: concert7.id)
ticket5 = Ticket.create(user_id: user5.id, concert_id: concert18.id)
ticket6 = Ticket.create(user_id: user6.id, concert_id: concert20.id)
ticket7 = Ticket.create(user_id: user7.id, concert_id: concert4.id)
ticket8 = Ticket.create(user_id: user8.id, concert_id: concert11.id)
ticket9 = Ticket.create(user_id: user1.id, concert_id: concert5.id)
ticket10 = Ticket.create(user_id: user2.id, concert_id: concert7.id)
ticket11 = Ticket.create(user_id: user3.id, concert_id: concert16.id)
ticket12 = Ticket.create(user_id: user4.id, concert_id: concert2.id)
ticket13 = Ticket.create(user_id: user5.id, concert_id: concert17.id)
ticket14 = Ticket.create(user_id: user6.id, concert_id: concert10.id)
ticket15 = Ticket.create(user_id: user7.id, concert_id: concert10.id)
ticket16 = Ticket.create(user_id: user8.id, concert_id: concert11.id)
ticket17 = Ticket.create(user_id: user1.id, concert_id: concert18.id)
ticket18 = Ticket.create(user_id: user2.id, concert_id: concert4.id)
ticket19 = Ticket.create(user_id: user3.id, concert_id: concert20.id)
ticket20 = Ticket.create(user_id: user4.id, concert_id: concert17.id)
ticket21 = Ticket.create(user_id: user5.id, concert_id: concert16.id)
ticket22 = Ticket.create(user_id: user6.id, concert_id: concert15.id)
ticket23 = Ticket.create(user_id: user7.id, concert_id: concert6.id)
ticket24 = Ticket.create(user_id: user8.id, concert_id: concert9.id)

10000.times{Ticket.create(user_id: rand(1000), concert_id: rand(20))}

