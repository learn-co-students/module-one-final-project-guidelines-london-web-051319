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

   def add_card(card_number)
      if self.card_number != nil
         puts "Please change existing card details"
         return
      else
         self.update(card_number: card_number)
         self
      end
   end

   def update_name(new_name)
      self.update(name: new_name)
      self
      puts "Record updated"
   end

   def update_dob(value)
      self.update(dob: value)
      self
      puts "Record updated"
   end

   def update_card_details(new_card_no)
      if self.card_number != nil
         self.remove_card
         self.update(card_number: new_card_no)
      else
         self.update(card_number: new_card_no)
      self
      end
      puts "Record updated"
   end

   def remove_card
      self.update(card_number: nil)
      self
   end

   def my_concerts_list
      concert_ids = Ticket.all.select{|inst| inst.user_id == self.id}.map{|inst| inst.concert_id}
      list = Concert.all.select{|inst| concert_ids.include?(inst.id)}.map(&:name)
      puts list # added in to work with the CLI
   end

   def my_concerts
      concert_ids = Ticket.all.select{|inst| inst.user_id == self.id}.map{|inst| inst.concert_id}
      Concert.all.select{|inst| concert_ids.include?(inst.id)}
   end

   def buy_ticket(concert_name)
      concert = Concert.all.find{|inst| inst.name == concert_name}
      Ticket.create(user_id: self.id, concert_id: concert.id)
   end

   def cancel_ticket(concert_name)
      concert = Concert.all.find{|inst| inst.name == concert_name}
      Ticket.all.select{|inst| inst.user_id == self.id && inst.concert_id == concert.id}[0].destroy
   end

end