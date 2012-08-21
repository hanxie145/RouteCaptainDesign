class User
  include Mongoid::Document
  include Mongoid::Timestamps
  authenticates_with_sorcery!
  attr_accessible :name, :email
  field :email
  field :name
  field :status
  field :admin, type: Boolean
  validates :email, presence: true, uniqueness: true
  def self.find_by_email(email)
    where(:email => email).first
  end
  def admin?
    return !admin || admin.nil? ? false : true
  end
end