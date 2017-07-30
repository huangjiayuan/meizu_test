class PhotosController < ApplicationController
  def index
    @tags = Tag.all
    #@photos = Photo.all.page(1).per(9)
  end

  def uploadpicture
    qiniu = QiniuConfig.upload(params[:fileUp].path,params[:fileName])
    Photo.create(:title => qiniu[:result]["key"])
    @tags = Tag.all
    @photos = Photo.all.page(1).per(9)
    render :index
  end
  def page
    ap params

    if params[:tag_id].present?
      tag = Tag.find(params[:tag_id])
      @tag_title = tag.try(:title)
      photos = tag.photos
    else
      @tag_title = 'All'
      photos = Photo.all
    end
    @photos = photos.page(params[:page]).per(9)
    #binding.pry
    render :partial => 'photo'
  end
end
