class Category < ActiveRecord::Base

  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  has_many :modeles

  scope :sorted, -> { order(:name) }

  def to_s
    name.to_s
  end

  def pdu?
    name=='Pdu'
  end
end
