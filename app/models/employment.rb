class Employment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :commany_name, type: String
  field :url,type: String
  field :url_from, type:String

end
