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

o2 = Venue.create(name: "O2 Arena", website_url: "https://www.theo2.co.uk", location: "London, UK", facilities: ["bars", "restaurants", "bathrooms", "disabled access"], email: "02@arenauk.com", password: "we're_big")
nec = Venue.create(name: "NEC", website_url: "http://www.thenec.co.uk/whats-on/", location: "Birmingham, UK", facilities: ["bars", "restaurants", "bathrooms", "disabled access"], email: "  ", password: "expo")
symphony = Venue.create(name: "Symphony Hall", website_url: "https://www.thsh.co.uk", location: "Birmingham, UK", facilities: ["bathrooms", "disabled access", "art gallery", "cloakroom"], email: "symphony@classical.co.uk", password: "acoustics")
albert = Venue.create(name: "Royal Albert Hall", website_url: "https://www.royalalberthall.com", location: "London, UK", facilities: ["bathrooms", "disabled access"], email: "alby@royalalbert.com", password: "princealbert")
wembley = Venue.create(name: "Wembley Stadium", website_url: "http://www.wembleystadium.com", location: "London, UK", facilities: ["bars", "restaurants", "bathrooms", "disabled access"], email: "wembley@statdiumsuk.co.uk", password: "national_pride_apparently")
manchester = Venue.create(name: "Manchester Arena", website_url: "http://www.manchester-arena.com", location: "Manchester, UK", facilities: ["bars", "restaurants", "bathrooms", "disabled access"], email: "manc@arenasuk.co.uk", password: "always_raining")
o2_newc = Venue.create(name: "O2 Academy Newcastle", website_url: "https://academymusicgroup.com/o2academynewcastle/", location: "Newcastle, UK", facilities: ["bars", "bathrooms", "disabled access"], email: "02_newc@arenauk.com", password: "waiai*")
rock = Venue.create(name: "Rock City", website_url: "https://www.rock-city.co.uk", location: "Nottingham, UK", facilities: ["bars", "bathrooms"], email: "notts@thecity.co.uk", password: "rockon")

user1 = User.create(name: "Bobby Harrisson", card_number: rand(1...100000000000000000), email: "bob@fmail.com", password: "asjhdli@")
user2 = User.create(name: "Claire Redbridge", card_number: rand(1...100000000000000000), email: "claire@atlook.com", password: "WJAs7d8")
user3 = User.create(name: "Asim Qurashee", card_number: rand(1...100000000000000000), email: "qshi@wahoo.co.uk", password: "cueball")
user4 = User.create(name: "Sophia Mensheviska", card_number: rand(1...100000000000000000), email: "soph67@fmail.com", password: "rooter")
user5 = User.create(name: "Lena Orgolova", card_number: rand(1...100000000000000000), email: "lena@rumail.com", password: "A&S(d7h")
user6 = User.create(name: "Sam Gamgee", card_number: rand(1...100000000000000000), email: "mrfrodo@middleearth.net", password: "precious")
user7 = User.create(name: "Alex Ramsay", card_number: rand(1...100000000000000000), email: "ramsaaay@fmail.com", password: "SKDHJoa7")
user8 = User.create(name: "Mo Farrar", card_number: rand(1...100000000000000000), email: "mozy@fmail.com", password: "sdlhasD#")

concert1 = Concert.create(name: "Fractured Future Tour: London", price: 60.00, website_url: "TBC", artist_id: muse.id, venue_id: o2.id)
concert2 = Concert.create(name: "Lovin' it up 2019", price: 75.00, website_url: "TBC", artist_id: aerosmith.id, venue_id: wembley.id)
concert3 = Concert.create(name: "Summer Nights", price: 40.00, website_url: "TBC", artist_id: lso.id, venue_id: albert.id)
concert4 = Concert.create(name: "Despacito", price: 35.00, website_url: "TBC", artist_id: fonsi.id, venue_id: manchester.id)
concert5 = Concert.create(name: "Green Grass Tour: Birmingham", price: 65.00, website_url: "TBC", artist_id: jones.id, venue_id: nec.id)
concert6 = Concert.create(name: "Metallicats", price: 60.00, website_url: "TBC", artist_id: metallica.id, venue_id: o2.id)
concert7 = Concert.create(name: "Raise Vibrations", price: 50.00, website_url: "TBC", artist_id: lenny.id, venue_id: o2_newc.id)
concert8 = Concert.create(name: "Spice It Up!", price: 120.00, website_url: "TBC", artist_id: spice.id, venue_id: nec.id)
concert9 = Concert.create(name: "Mindgoogling: London", price: 70.00, website_url: "TBC", artist_id: bill.id, venue_id: albert.id)
concert10 = Concert.create(name: "Fractured Future Tour: Newcastle", price: 60.00, website_url: "TBC", artist_id: muse.id, venue_id: o2_newc.id)
concert11 = Concert.create(name: "Fractured Future Tour: Manchester", price: 60.00, website_url: "TBC", artist_id: muse.id, venue_id: manchester.id)
concert12 = Concert.create(name: "Fractured Future Tour: Nottingham", price: 60.00, website_url: "TBC", artist_id: muse.id, venue_id: rock.id)
concert13 = Concert.create(name: "Fractured Future Tour: Wembley", price: 90.00, website_url: "TBC", artist_id: muse.id, venue_id: wembley.id)
concert14 = Concert.create(name: "Green Grass Tour: Manchester", price: 65, website_url: "TBC", artist_id: jones.id, venue_id: manchester.id)
concert15 = Concert.create(name: "Green Grass Tour: London", price: 100, website_url: "TBC", artist_id: jones.id, venue_id: wembley.id)
concert16 = Concert.create(name: "Oh no!", price: 40, website_url: "TBC", artist_id: fonsi.id, venue_id: nec.id)
concert17 = Concert.create(name: "Mindgoogling: Newcastle", price: 70, website_url: "TBC", artist_id: bill.id, venue_id: o2_newc.id)
concert18 = Concert.create(name: "Spice Up Your Life: Manchester", price: 90, website_url: "TBC", artist_id: spice.id, venue_id: manchester.id)
concert19 = Concert.create(name: "Spice Up Your Life: Newcastle", price: 90, website_url: "TBC", artist_id: spice.id, venue_id: o2_newc.id)
concert20 = Concert.create(name: "Good Vibrations", price: 60, website_url: "TBC", artist_id: lenny.id, venue_id: o2.id)



# concert1 = Concert.create(name: "Fractured Future Tour", price: 60, date: 19-06-04, start_time: 19:00, end_time: 23:30, website_url: "TBC", artist_id: 1, venue_id: 1)
# concert2 = Concert.create(name: "Lovin' it up 2019", price: 75, date: 19-06-29, start_time: 19:30, end_time: 23:45, website_url: "TBC", artist_id: 2, venue_id: 5)
# concert3 = Concert.create(name: "Summer Nights", price: 40, date: 19-07-05, start_time: 17:30, end_time: 20:30, website_url: "TBC", artist_id: 3, venue_id: 4)
# concert4 = Concert.create(name: "Despacito", price: 35, date: 19-07-15, start_time: 20:00, end_time: 23:50, website_url: "TBC", artist_id: 4, venue_id: 6)
# concert5 = Concert.create(name: "Green Grass Tour", price: 65, date: 19-08-01, start_time: 19:00, end_time: 23:00, website_url: "TBC", artist_id: 5, venue_id: 2)
# concert6 = Concert.create(name: "Metallicats", price: 60, date: 19-08-17, start_time: 19:20, end_time: 23:30, website_url: "TBC", artist_id: 6, venue_id: 1)
# concert7 = Concert.create(name: "Raise Vibrations", price: 50, date: 19-08-31, start_time: 19:30, end_time: 23:30, website_url: "TBC", artist_id: 7, venue_id: 7)
# concert8 = Concert.create(name: "Spice It Up!", price: 120, date: 19-09-03, start_time: 19:00, end_time: 23:00, website_url: "TBC", artist_id: 8, venue_id: 2)
# concert9 = Concert.create(name: "Mindgoogling", price: 70, date: 19-09-20, start_time: 19:00, end_time: 23:00, website_url: "TBC", artist_id: 9, venue_id: 4)

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