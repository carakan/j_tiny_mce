class TinyMcePhotosController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @photos = TinyMcePhoto.paginate :page => params[:page], :order => "created_at DESC", :per_page => 10

    respond_to do |format|
      format.html {  render :partial => 'photo_list', :locals => { :photos => @photos }, :layout => false   }
      format.js do |page|
        page.replace_html :dynamic_images_list, :partial => 'photo_list', :locals => { :photos => @photos }
      end
    end
  end

  def create
    @photo = TinyMcePhoto.new(params[:media])
    #@photo.user = current_user
    @photo.save!
  end
end