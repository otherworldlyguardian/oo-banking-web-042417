class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender, @receiver, @amount = sender, receiver, amount
    @status = "pending"
  end

  def valid?
    sender.valid? && receiver.valid? && sender.balance > self.amount
  end

  def execute_transaction
    if self.status == "pending" && self.valid?
      self.status = "complete"
      self.sender.balance -= self.amount
      self.receiver.balance += self.amount
    else
      self.status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete" && self.valid?
      self.status = "reversed"
      self.sender.balance += self.amount
      self.receiver.balance -= self.amount
    end
  end

end
