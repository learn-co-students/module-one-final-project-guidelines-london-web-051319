class Ticket < ActiveRecord::Base
   belongs_to :user
   belongs_to :concert

   # CLASS *************************

   def self.tickets_sold
      Ticket.all.count
   end

   

   # INSTANCE ********************

   def concert
      Concert.all.select{|inst| inst.id == self.concert_id}
   end

   def customer
      User.all.select{|inst| inst.id == self.user_id}
   end

end