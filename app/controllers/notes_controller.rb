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
    note = params[:file].read
    note = JSON.parse note
    p note
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
