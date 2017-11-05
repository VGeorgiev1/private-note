class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  def view
    @note = Note.find_by slug: params[:id];
    if @note!=nil
      @note.destroy
      @msg=@note.msg;
    else
      @msg="No such note!"
    end  

    render "note_info"
  end
  def api
    urlsafe=SecureRandom.urlsafe_base64(32);
    p params
    res='json'
    if request.content_type =~ /xml/
      params[:message]=Nokogiri::XML(request.body.read).xpath('//message').children[0].to_s
      res='xml'
    end
    note=Note.new({msg:params[:message], slug: urlsafe})
    note.save
    if res=='json'
      respond_to do |format| 
        format.json {render json: {'url' => request.base_url+ "/view/"+note.slug}}
      end  
    else
      respond_to do |format| 
        format.xml {render xml: "<?xml version='1.0' encoding='UTF-8'?><url>#{request.base_url+ '/view/'+note.slug}</url>"}
      end  
    end  
  end
  # GET /notes/new
  def new
    @urlsafe=SecureRandom.urlsafe_base64(32)
    @note = Note.new({msg: params[:content], slug: @urlsafe})
    @note.save
    domain=request.base_url
    @url=domain +"/view/"+ @note.slug 
    @action="/view/"+ @note.slug 
    render "link_info" 
  end
end
