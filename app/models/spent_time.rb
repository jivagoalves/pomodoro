class SpentTime < ActiveRecord::Base
  attr_accessible :activity_id, :time

  belongs_to :activity

  validates_presence_of :activity

  scope :updated_today, lambda { where('updated_at > ?', Date.today) }

  after_initialize do |st|
    st.time ||= 0
  end

  def add_pomodoro
    self.time ||= 0
    self.time += 1500
  end
end
