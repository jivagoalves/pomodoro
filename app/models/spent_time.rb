class SpentTime < ActiveRecord::Base
  attr_accessible :activity_id, :time

  belongs_to :activity

  validates :activity, presence: true

  scope :updated_today, lambda {
    where('updated_at > ?', Date.today)
  }

  def self.last_updated
    order('updated_at DESC').first
  end

  after_initialize do |st|
    st.time ||= 0
  end
end
