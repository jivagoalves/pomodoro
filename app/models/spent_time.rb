class SpentTime < ActiveRecord::Base
  attr_accessible :activity_id, :time

  belongs_to :activity

  after_initialize do |st|
    st.time ||= 0
  end

  validates_presence_of :activity

  def add_pomodoro
    self.time ||= 0
    self.time += 1500
  end
end
