class User < ApplicationRecord

  def self.in_batches(&block)
    #find_each will batch the results instead of getting all in one go
    find_each(batch_size: 100) do |transaction|
      yield transaction
    end
  end
end
