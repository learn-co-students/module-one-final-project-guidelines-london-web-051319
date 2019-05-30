class User < ActiveRecord::Base
   belongs_to :venue

   # CLASS ********************

   def self.new_user(user={})
      User.create(user)
   end

   def self.remove_user(user_name)
      User.all.select{|inst| inst.name == user_name}[0].destroy
   end

   def self.find_user_by_name(user_name)
      User.all.find{|inst| inst.name == user_name}
   end

   def self.find_user_by_email(email_address) #this method is used to check the email address for sign in in cli.rb
      self.where(["email = ?", email_address]).first
   end

   # INSTANCE ****************

   def add_card(new_number, card_slot)
      if card_slot == 0
         self.update(card_1_number: new_number)
      elsif card_slot == 1
         self.update(card_2_number: new_number)
      elsif card_slot == 2
         self.update(card_3_number: new_number)
      end
      puts "Your new card has been added."
   end

   def update_name(new_name)
      self.update(name: new_name)
      self
      puts "Your username has been updated."
   end

   def update_dob(value)
      self.update(dob: value)
      self
      puts "Your DOB has been updated."
   end

   def update_email(new_email)
      self.update(email: new_email)
      puts "Your email has been updated."
   end

   def update_password(new_password)
      self.update(password: new_password)
      puts "Your password has been updated."
   end

   def update_card_details(new_card_no, card_to_update)
      if card_1_number == card_to_update
         self.update(card_1_number: new_card_no)
      elsif card_2_number == card_to_update
         self.update(card_2_number: new_card_no)
      elsif card_3_number == card_to_update
         self.update(card_3_number: new_card_no)
      end
      puts "Your card details have been updated."
   end

   def remove_card(card_number)
      if card_1_number == card_number
         self.update(card_1_number: nil)
      elsif card_2_number == card_number
         self.update(card_2_number: nil)
      elsif card_3_number == card_number
         self.update(card_3_number: nil)
      end
      puts "Your card has been removed."
   end

   def my_concerts_list
      concert_ids = Ticket.all.select{|inst| inst.user_id == self.id}.map{|inst| inst.concert_id}
      list = Concert.all.select{|inst| concert_ids.include?(inst.id)}.map{|inst| "#{inst.name} | #{inst.artist.name} | #{inst.date} | #{inst.venue.location}"}
      if list.length == 0
         puts "You currently have no saved concerts."
      else
         puts list # added in to work with the CLI
      end
   end

   def my_concerts
      concert_ids = Ticket.all.select{|inst| inst.user_id == self.id}.map{|inst| inst.concert_id}
      Concert.all.select{|inst| concert_ids.include?(inst.id)}
   end

   def buy_ticket(concert_name)
      concert = Concert.all.find{|inst| inst.name.downcase == concert_name.downcase}
      if concert == nil
         puts "Concert does not exist"
         exit
      else
      Ticket.create(user_id: self.id, concert_id: concert.id)
      puts "You have purchased tickets for #{concert.name}"
      end
   end

   def cancel_ticket(concert_name) 
      concert = Concert.all.find{|inst| inst.name.downcase == concert_name.downcase}
      Ticket.all.find{|inst| inst.user_id == self.id && inst.concert_id == concert.id}.destroy
   end

end