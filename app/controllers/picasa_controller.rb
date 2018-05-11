class PicasaController < ApplicationController


  def index
    client = Picasa::Client.new(user_id: "109613963797368081500", authorization_header: "CKn0rYueqZbZpAE")

    album =  client.album.list
    raise album.to_yaml

    render json: {  :status => 'ok' }
  end

end
