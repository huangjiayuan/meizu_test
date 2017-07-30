class Tag
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :photos, autosave: true

  field :title, type: String, default: "" #tag

end