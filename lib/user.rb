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

   # def self.delete_user(user)
   #    user.destroy
   # end

   # INSTANCE ****************

   
   def update_name(new_name)
      self.update(name: new_name)
      self
      puts "Your username has been updated.".colorize(:magenta)
   end
   
   def update_dob(value)
      self.update(dob: value)
      self
      puts "Your DOB has been updated.".colorize(:magenta)
   end
   
   def update_email(new_email)
      self.update(email: new_email)
      puts "Your email has been updated.".colorize(:magenta)
   end
   
   def update_password(new_password)
      self.update(password: new_password)
      puts "Your password has been updated.".colorize(:magenta)
   end
   
   def validate_card_number(number)
      if number.to_i.class == Integer && number.to_i.to_s.length == 16
         number
      else
         nil
      end
   end
   
   def add_card(new_number, card_slot)
      self.validate_card_number(new_number).to_i
      unless self.validate_card_number(new_number) == nil
         if card_slot == 0
            self.update(card_1_number: new_number)
         elsif card_slot == 1
            self.update(card_2_number: new_number)
         elsif card_slot == 2
            self.update(card_3_number: new_number)
         end
         puts "Your new card has been added.".colorize(:magenta)
      else
         puts "The specified card number is invalid.".colorize(:red)
      end
   end

   def update_card_details(new_number, card_to_update)
      self.validate_card_number(new_number).to_i
      unless self.validate_card_number(new_number) == nil
         if card_1_number == card_to_update
            self.update(card_1_number: new_number)
         elsif card_2_number == card_to_update
            self.update(card_2_number: new_number)
         elsif card_3_number == card_to_update
            self.update(card_3_number: new_number)
         end
         puts "Your card details have been updated.".colorize(:magenta)
      else
         puts "The specified card number is invalid.".colorize(:red)
      end
   end

   def remove_card(card_number)
      if card_1_number == card_number
         self.update(card_1_number: nil)
      elsif card_2_number == card_number
         self.update(card_2_number: nil)
      elsif card_3_number == card_number
         self.update(card_3_number: nil)
      end
      puts "Your card has been removed.".colorize(:magenta)
   end

   def my_concerts_list
      concert_ids = Ticket.all.select{|inst| inst.user_id == self.id}.map{|inst| inst.concert_id}
      list = Concert.all.select{|inst| concert_ids.include?(inst.id)}.map{|inst| "#{inst.name} | #{inst.artist.name} | #{inst.date} | #{inst.venue.location}"}
      if list.length == 0
         puts "You currently have no saved concerts.".colorize(:cyan)
      else
         puts list.collect{|inst| inst.colorize(:cyan)} # added in to work with the CLI
      end
   end

   def my_concerts
      concert_ids = Ticket.all.select{|inst| inst.user_id == self.id}.map{|inst| inst.concert_id}
      Concert.all.select{|inst| concert_ids.include?(inst.id)}
   end

   def buy_ticket(concert_name)
      concert = Concert.all.find{|inst| inst.name.downcase == concert_name.downcase}
      if concert == nil
         puts "Concert does not exist".colorize(:red)
         exit
      else
      Ticket.create(user_id: self.id, concert_id: concert.id)
      puts "You have purchased tickets for #{concert.name}".colorize(:cyan)
      end
   end

   def cancel_ticket(concert_name) 
      concert = Concert.all.find{|inst| inst.name.downcase == concert_name.downcase}
      Ticket.all.find{|inst| inst.user_id == self.id && inst.concert_id == concert.id}.destroy
   end

   def cancel_all_tickets
      tickets = Ticket.all.select{|inst| inst.user_id == self.id}
      tickets.each{|inst| inst.destroy}
   end

end