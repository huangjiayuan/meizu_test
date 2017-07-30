class Photo
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :tags, autosave: true

  before_save :add_tag

  field :title, type: String, default: "" #title

  def tag_title
    tag_title = ""
    self.tags.each{|tag| tag_title += tag.title}
    tag_title
  end

  def add_tag
    self.tags << Tag.find_by(:title => 'unTag') if self.tags.blank?
  end
end