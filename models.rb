class Scan < Sequel::Model
  def before_save
    self.created_at ||= Time.now
  end
end
