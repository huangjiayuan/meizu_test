class PhotosController < ApplicationController
  before_action :set_photo, only: [:drag_photo_tag, :update_photo_tag]
  def index
  end

  def tags
    @tags = Tag.all
    render :partial => 'tag'
  end

  def uploadpicture
    qiniu   = QiniuConfig.upload(params[:fileUp].path,params[:fileName])
    Photo.create(:title => qiniu[:result]["key"])
    @tags   = Tag.all
    @photos = Photo.all.page(1).per(9)
    render :index
  end

  def drag_photo_tag
    tag = Tag.find(params[:tag_id])

    @photo.tags << tag unless @photo.tags.include? tag
    tag.photos << @photo unless tag.photos.include? @photo

    respond_to do |format|
      format.json { render json: {message: "ok"}, status: :ok }
    end
  end

  def update_photo_tag
    if params[:tag_title].present?
      tag = Tag.find_or_create_by(:title => params[:tag_title])
      @photo.tags.clear
      #photo.save
      @photo.tags << tag
    end
    respond_to do |format|
      format.json { render json: {message: "ok"}, status: :ok }
    end
  end

  def page
    if params[:tag_id].present?
      tag        = Tag.find(params[:tag_id])
      @tag_title = tag.title
      photos     = tag.photos
    else
      @tag_title = 'All'
      photos     = Photo.all
    end
    @photos = photos.page(params[:page]).per(9)
    #binding.pry
    render :partial => 'photo'
  end

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end

end
