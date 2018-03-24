class Ticket < ApplicationRecord
  serialize :bracket, JSON
end
