class TinyMcePhoto < ActiveRecord::Base
  has_attached_file :photo, :styles => {:medium => ["200x200>", :jpg],  :small => ["80x80>", :jpg], :original => ["600x600>", :jpg]}, :url => "/uploads/:id_partition/:style/:basename.:extension", :path => ":rails_root/public/uploads/:id_partition/:style/:basename.:extension"
  belongs_to :user

  # validations
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']

  def display_name
    self.content ? self.content : self.created_at.strftime("created on: %m/%d/%y")
  end
end