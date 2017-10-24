class PhotosController < ApplicationController
  before_action :set_photo, only: [:drag_photo_tag, :update_photo_tag]
  def index
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    url = URI::escape("https://www.lagou.com/jobs/list_ruby?px=default&city=%E5%85%A8%E5%9B%BD#filterBox")
    page = agent.get url
ap page.links
  end

  def zhilian
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    url = URI::escape("http://news.qq.com/a/20170815/035706.htm")
    page = agent.get url
    agent.open_timeout=10
    page.encoding='utf-8'
    ap page
    page.save(page.html)
    links = page.links
    # uripage = agent.get 'http://jobs.zhaopin.com/677618624250490.htm'
    # ap uripage.title()
    # links.each_with_index  do |link,index|
    #   uri = link.uri()
      #uripage = agent.get uri if (uri.to_s.include? 'jobs.zhaopin.com') && (uri.to_s.split('.').last.include? 'htm')
      # if uripage.present?
      #   title_array = uripage.title.split('-')
      #   if title_array.size == 2
      #     name_array = title_array[0].split('_')
      #     if name_array.size == 2
      #       Employment.find_or_create_by(:title => name_array[0].gsub('【',''),
      #                                    :commany_name => name_array[1].gsub('人才招聘信息】',''),
      #                                    :url => uri.to_s,:url_from => title_array[1])
      #     end
      #   end
      # end

    # end
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
