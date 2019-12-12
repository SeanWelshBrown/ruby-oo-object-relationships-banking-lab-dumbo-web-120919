class Transfer

  @@completed_transactions = []

  attr_accessor :sender, :receiver, :amount, :status
  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    if self.sender.valid? && self.receiver.valid? == true
      return true
    end
  end

  def execute_transaction
    if !self.valid? || self.sender.balance < self.amount
      self.status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
    if !@@completed_transactions.include?(self)
      self.receiver.balance += @amount
      self.sender.balance -= @amount
      self.status = "complete"
      @@completed_transactions << self
    end
  end

  def reverse_transfer
    if @@completed_transactions.last.status == "complete"
      self.sender.balance += @amount
      self.receiver.balance -= @amount
      self.status = "reversed"
    end
  end

end
