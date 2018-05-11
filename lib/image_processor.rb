class ImageProcessor
  def convert_to_med_framed(temp_object)
    tempfile = new_tempfile
    tempfile2 = new_tempfile
    tempfile3 = new_tempfile

    # args = " convert #{temp_object.path} -resize '346x234^' -crop '346x234+0+0' #{tempfile.path} "
    args = " convert #{temp_object.path} -resize '455x308^' -crop '455x308+0+0' #{tempfile.path} "

    result = `#{args}`
    # arg2 = "composite -compose atop -geometry +21+18 #{tempfile.path} lib/collage_bg_med.jpg #{tempfile2.path}"
    arg2 = "composite -compose atop -geometry +23+20 #{tempfile.path} lib/collage_bg_med.jpg #{tempfile2.path}"
    result2 = ` #{arg2} `
    arg3 = "composite lib/collage_watermark_med.png #{tempfile2.path}  #{tempfile3.path} "
    result3 = ` #{arg3} `

    tempfile3
  end

  def convert_filter_gotham(temp_object)
    tempfile = new_tempfile
    # args = " convert #{temp_object.path} -resize '346x234^' -crop '346x234+0+0' #{tempfile.path} "
    args = " convert #{temp_object.path} -contrast -modulate 100,150,100 -auto-gamma #{tempfile.path} "

    result = `#{args}`
    # # arg2 = "composite -compose atop -geometry +21+18 #{tempfile.path} lib/collage_bg_med.jpg #{tempfile2.path}"
    # arg2 = "composite -compose atop -geometry +23+20 #{tempfile.path} lib/collage_bg_med.jpg #{tempfile2.path}"
    # result2 = ` #{arg2} `
    # arg3 = "composite lib/collage_watermark_med.png #{tempfile2.path}  #{tempfile3.path} "
    # result3 = ` #{arg3} `

    tempfile
  end

  private

  def new_tempfile(ext=nil)
    tempfile = ext ? Tempfile.new(['dragonfly', ".#{ext}"]) : Tempfile.new('dragonfly')
    tempfile.binmode
    tempfile.close
    tempfile
  end
end