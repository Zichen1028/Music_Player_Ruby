require 'rubygems'
require 'gosu'


module ZOrder
  BACKGROUND, PAGE, UI = *0..2
end

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

$genre = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class Favourite
	attr_accessor :album_id, :track_id
end

class Track
	attr_accessor :name, :location
	def initialize (name='', location='')
    @name = name
    @location = location
	end
end

class Album
	attr_accessor :title, :artist, :genre, :tracks, :year
	def initialize (title='', artist='', genre='', tracks='', year='')
    @title = title
    @artist = artist
    @genre = genre
    @tracks = tracks
    @year = year
	end
end


class MusicPlayerMain < Gosu::Window
	
	def initialize()
	    super 1200,800,false 
        self.caption = " "*90+"Music Player"
        @volume = 0.5
        @page = -1
        @selected_album = 0
        @selected_track = 0
        @genre_selected = 0
        
        @album_id = 0
        @track_id = 0
        @playitem = Favourite.new()
        @playlist = Array.new()
        
        @text = Gosu::Font.new(self,Gosu::default_font_name, 20)
        @albums = read_albums_file("media/albums.txt")
        @bg = Gosu::Image.new("picture/Cover.jpg")
        @cover = Gosu::Image.new("picture/welcome.png")
        
		    @album1 = Gosu::Image.new("picture/album1.png")
		    @album2 = Gosu::Image.new("picture/album2.jpg")
		    @album3 = Gosu::Image.new("picture/album3.jpg")
        @album4 = Gosu::Image.new("picture/album4.jpg")
        @album5 = Gosu::Image.new("picture/album5.png")
        @album6 = Gosu::Image.new("picture/album6.jpg")
        @album7 = Gosu::Image.new("picture/album7.png")
        @album8 = Gosu::Image.new("picture/album8.jpg")
        @button1 = Gosu::Image.new("picture/button1.png")
        @button2 = Gosu::Image.new("picture/button2.png")
        @button_home = Gosu::Image.new("picture/Home.png")
        @volume_up = Gosu::Image.new("picture/volume_up.png")
        @volume_down = Gosu::Image.new("picture/volume_down.png")
        @volume_button = Gosu::Image.new("picture/volume.png")
        @pause = Gosu::Image.new("picture/pause.png")
        @myfavourite = Gosu::Image.new("picture/Myfavourite.png")
        @ADD = Gosu::Image.new("picture/add.png")

        @tracklist = Array["cracklinrosie", "Soolaimon","SweetCaroline","Lemon",
        "Cranberry&Pancake","PaperFlower","HotelCalifornia","NewKidinTown","WastedTime",
        "Eraser","Dive","Shapeofyou","BadRomance","Alejandro","LoveGame",
        "TakeYourselfHome","Youth","LuckyStrike",
        "TreatYouBetter","Mercy","InMyBlood","WhenIWasYourMan","Treasure","UptownFunk"]
        @tracks = Array.new(@tracklist.size)
        i = 0
        until i == @tracklist.size 
          @tracks[i] = Gosu::Song.new(self, "media/" + @tracklist[i] + ".mp3")
          i += 1
        end
	end
  
    def read_track (music_file)
    name = music_file.gets.chomp()
    location = music_file.gets.chomp()
    track = Track.new(name,location)
    return track
    end

  def read_tracks (music_file)
    number_of_tracks = music_file.gets.to_i
    tracks = Array.new()
    for i in 0..(number_of_tracks-1)
        tracks << read_track(music_file)
    end
    return tracks
  end

  def read_album(music_file)
    myalbum = Album.new()
	  myalbum.title = music_file.gets.chomp() #line 2: albums title
	  myalbum.artist = music_file.gets.chomp() #line 3: artist
    myalbum.genre = music_file.gets.to_i() #line 4: genre
    myalbum.year = music_file.gets.to_i()
    myalbum.tracks = read_tracks(music_file) # tracks
	return myalbum
  end

  def read_albums(music_file)
    total_albums = music_file.gets().to_i #line 1
    albums = Array.new()
    for i in 0..(total_albums-1)
        album = read_album(music_file)
        albums << album
    end
    return albums
  end

  def read_albums_file(filename)
    music_file = File.new(filename, "r")
    albums = read_albums(music_file)
    music_file.close()
    return albums
  end

  def draw_background()
    @bg.draw(0,0,ZOrder::BACKGROUND,0.75,0.7519)
  end

  def draw_genre()
    @text.draw("POP", 20, 20, 2, 3, 3, 0xff_FFD700)
    @text.draw("CLASSIC", 20, 90, 2, 3, 3, 0xff_FFD700)
    @text.draw("JAZZ", 20, 160, 2, 3, 3, 0xff_FFD700)
    @text.draw("ROCK", 20, 230, 2, 3, 3, 0xff_FFD700)
  end

  def draw_POP()
    @album1.draw(500, 45, 2, 0.1741, 0.1741)
    @album2.draw(500, 140, 2, 0.2444, 0.2444)
  end

  def draw_CLASSIC()
    @album3.draw(500, 45, 2, 0.2444, 0.2444)
    @album4.draw(500, 140, 2, 0.03161, 0.03161)
  end

  def draw_JAZZ()
    @album5.draw(500, 45, 2, 0.25, 0.25)
    @album6.draw(500, 140, 2, 0.1957, 0.3073)
  end

  def draw_ROCK()
    @album7.draw(500, 45, 2, 0.25, 0.25)
    @album8.draw(500, 140, 2, 0.2444, 0.2444)
  end

  def draw_cover()
    @cover.draw(300,200,ZOrder::PAGE,1.0,1.0)
  end

  def draw_albums_page1()
	  @album1.draw(0,0,ZOrder::PAGE,1.27,0.95)
	  @album2.draw(400,0,ZOrder::PAGE,1.7778,1.3333)
	  @album3.draw(0,300,ZOrder::PAGE,1.7778,1.3333)
	  @album4.draw(400,300,ZOrder::PAGE,0.2299,0.1724)
  end

  def draw_albums_page2()
    @album5.draw(0,0,ZOrder::PAGE,1.8182,1.3636)
    @album6.draw(400,0,ZOrder::PAGE,1.4235,1.6760)
    @album7.draw(0,300,ZOrder::PAGE,1.8182,1.3636)
    @album8.draw(400,300,ZOrder::PAGE,1.7778,1.3333)
  end
    
  def draw_button_home()
    @button_home.draw(1020,170,ZOrder::UI,0.6818,0.6818)
    @myfavourite.draw(1020,20,ZOrder::UI,0.5,0.5)
    @button1.draw(1130,390,ZOrder::UI,0.2083,0.2083)
    @button2.draw(1130,430,ZOrder::UI,0.2083,0.2083)
  end

  def draw_volume()
    @volume_button.draw(510,740,ZOrder::UI,0.208, 0.208)
    @volume_down.draw(550,740,ZOrder::UI,0.208, 0.208)
    @pause.draw(590,740,ZOrder::UI,0.208,0.208)
    @volume_up.draw(630,740,ZOrder::UI,0.208, 0.208)
  end

  def draw_add_to_fav()
    for i in 0..2
        @ADD.draw(290, 680+i*20, ZOrder::PAGE, 0.5, 0.5) 
        i += 1
    end
  end

	def draw
        draw_background

        if @page == -1
           draw_cover() 
        end
        if @page == 0
           draw_button_home
           draw_volume
           draw_genre
        end
        if @page == 1
            draw_add_to_fav
            draw_button_home
            draw_volume
            draw_albums_page1
        end
        if @page == 2
            draw_add_to_fav
            draw_button_home
            draw_volume
            draw_albums_page2
        end
        if @page == 3 
            draw_button_home
            draw_volume
            @text.draw("My Favourite Song",220,300,ZOrder::PAGE,2,2,0xff_FFD700)
        end

#_________________mouse_over_album_____________#
        if @page == 1
            if album1_clicked
            @selected_album = 1
            end
            if album2_clicked
            @selected_album = 2
            end
            if album3_clicked
            @selected_album = 3
            end
            if album4_clicked
            @selected_album = 4
            end
        end
        
		    if @page == 2
            if album1_clicked
            @selected_album = 5
            end
            if album2_clicked
            @selected_album = 6
            end
            if album3_clicked
            @selected_album = 7
            end
            if album4_clicked
            @selected_album = 8
            end
		    end
        
#______________________mouse_over_track_area____________________#
        if (@page == 1) or (@page == 2)
          if (mouse_over_track1(mouse_x, mouse_y)) && (Gosu::button_down?Gosu::MsLeft)
            @selected_track = 1
		      elsif (mouse_over_track2(mouse_x, mouse_y)) && (Gosu::button_down?Gosu::MsLeft)
            @selected_track = 2
          elsif (mouse_over_track3(mouse_x, mouse_y)) && (Gosu::button_down?Gosu::MsLeft)
            @selected_track = 3
          end
        end


        if @page == 0
        for i in 0..(@albums.length-1)
            album = @albums[i]
            if album.genre == @genre_selected
                @text.draw("ALBUM GENRE: #{$genre[album.genre]}", 500, 20, 2, 1, 1, 0xff_FFD700)
                if (i == 0) or (i == 1)
                  draw_POP()
                  @text.draw("#{album.title}", 500 , i*100 + 100, 2, 1, 1, 0xff_FFD700)
                end
                if i == 2 or i == 3
                  draw_CLASSIC
                  @text.draw("#{album.title}", 500 , i*100 - 100, 2, 1, 1, 0xff_FFD700)
                end
                if i == 4 or i == 5
                  draw_JAZZ
                  @text.draw("#{album.title}", 500 , i*100 - 300, 2, 1, 1, 0xff_FFD700)
                end
                if i == 6 or i == 7
                  draw_ROCK
                @text.draw("#{album.title}", 500 , i*100 -500, 2, 1, 1, 0xff_FFD700)
                end
            end
        end
        end

        if (@page == 1) or (@page == 2)
        album = @albums[@selected_album-1]
        track = album.tracks[@selected_track.to_i-1]
        height = 20
        @text.draw("Album: " + album.title, 20, 620, 2, 1.0, 1.0, 0xff_FFD700)
        @text.draw("Artist: " + album.artist, 20, 645, 2, 1.0, 1.0, 0xff_FFD700) 
        @text.draw("Year: " + album.year.to_s, 250, 620, 2, 1, 1, 0xff_FFD700)
        @text.draw("Track <#{track.name}> from album <#{album.title}> now is playing...", 400, 650, 2, 1.0, 1.0, 0xff_FFD700)
        for index in 0..(album.tracks.length-1)
            track = album.tracks[index]
            @text.draw("Track#{index+1}: " + track.name, 20, 680 + height*index, 2, 1.0, 1.0, 0xff_FFD700)
        end
        end
        
#__________________ADD_BUTTON___________________#

        if @page == 1
            if album1_clicked
              @album_id = 1
              @playitem.album_id = @album_id
              @playlist << @playitem
            end
            if album2_clicked
              @album_id = 2
              @playitem.album_id = @album_id
              @playlist << @playitem
            end
            if album3_clicked
              @album_id = 3
              @playitem.album_id = @album_id
              @playlist << @playitem
            end
            if album4_clicked
              @album_id = 4
              @playitem.album_id = @album_id
              @playlist << @playitem
            end
        end
        
		if @page == 2
            if album1_clicked
              @album_id = 5
              @playitem.album_id = @album_id
              @playlist << @playitem
            end
            if album2_clicked
              @album_id = 6
              @playitem.album_id = @album_id
              @playlist << @playitem
            end
            if album3_clicked
              @album_id = 7
              @playitem.album_id = @album_id
              @playlist << @playitem
            end
            if album4_clicked
              @album_id = 8
              @playitem.album_id = @album_id
              @playlist << @playitem
            end
		end        

        if @page == 1 or @page == 2
            if (mouse_over_ADD1(mouse_x, mouse_y)) && (Gosu::button_down?Gosu::MsLeft)
              @track_id = 1 
              @playitem.track_id = @track_id
              @playlist << @playitem
            end
            if (mouse_over_ADD2(mouse_x, mouse_y)) && (Gosu::button_down?Gosu::MsLeft)
              @track_id = 2
              @playitem.track_id = @track_id
              @playlist << @playitem
            end
            if (mouse_over_ADD3(mouse_x, mouse_y)) && (Gosu::button_down?Gosu::MsLeft)
              @track_id = 3
              @playitem.track_id = @track_id
              @playlist << @playitem
            end
        end

        if @page == 3 
          for i in 0..(@playlist.length-1) 
          item = @playlist[i]   
          album = @albums[item.album_id-1] 
          track = album.tracks[item.track_id-1] 
          @text.draw(track.name, 550, 300, 2, 2, 2, 0xff_FFD700)
          end
        end


	end

	 def needs_cursor?; true; end
	 
#______________________________mouse_over_buttons______________________________#
	def mouse_over_album1(mouse_x, mouse_y)
		if ((mouse_x > 0 and mouse_x < 400) and (mouse_y > 0 and mouse_y < 300))
		  true
		else
		  false
		end
	end

	def mouse_over_album2(mouse_x, mouse_y)
		if ((mouse_x > 400 and mouse_x < 800) and (mouse_y > 0 and mouse_y < 300))
		  true
		else
		  false
		end
	end

	def mouse_over_album3(mouse_x, mouse_y)
		if ((mouse_x > 0 and mouse_x < 400) and (mouse_y > 300 and mouse_y < 600))
		  true
		else
		  false
		end
	end

	def mouse_over_album4(mouse_x, mouse_y)
		if ((mouse_x > 400 and mouse_x < 800) and (mouse_y > 300 and mouse_y < 600))
		  true
		else
		  false
		end
    end
    
    def mouse_over_POP(mouse_x, mouse_y)
        if ((mouse_x > 20 and mouse_x < 400) and (mouse_y > 20 and mouse_y < 80))
          true
        else
          false
        end
    end

    def mouse_over_CLASSIC(mouse_x, mouse_y)
        if ((mouse_x > 20 and mouse_x < 400) and (mouse_y > 90 and mouse_y < 150))
          true
        else
          false
        end
    end

    def mouse_over_JAZZ(mouse_x, mouse_y)
        if ((mouse_x > 20 and mouse_x < 400) and (mouse_y > 160 and mouse_y < 220))
          true
        else
          false
        end
    end

    def mouse_over_ROCK(mouse_x, mouse_y)
        if ((mouse_x > 20 and mouse_x < 400) and (mouse_y > 230 and mouse_y < 290))
          true
        else
          false
        end
    end
	
	def album1_clicked
		if mouse_over_album1(mouse_x, mouse_y) && (Gosu::button_down? Gosu::MsLeft)
		  true
		else
		  false
		end
	end
    
	def album2_clicked
		if mouse_over_album2(mouse_x, mouse_y) && (Gosu::button_down? Gosu::MsLeft)
		true
		else
		false
		end
	end

	def album3_clicked
		if mouse_over_album3(mouse_x, mouse_y) && (Gosu::button_down? Gosu::MsLeft)
		true
		else
		false
		end
	end

	def album4_clicked
		if mouse_over_album4(mouse_x, mouse_y) && (Gosu::button_down? Gosu::MsLeft)
		true
		else
		false
		end
	end

	def mouse_over_track1(mouse_x, mouse_y)
		if ((mouse_x > 20 and mouse_x < 260) and (mouse_y > 680 and mouse_y < 700))
			true
		else
			false
		end
	end

    def mouse_over_track2(mouse_x, mouse_y)
		if ((mouse_x > 20 and mouse_x < 260) and (mouse_y > 700 and mouse_y < 720))
			true
		else
			false
		end
	end
	
	def mouse_over_track3(mouse_x, mouse_y)
		if ((mouse_x > 20 and mouse_x < 260) and (mouse_y > 720 and mouse_y < 740))
			true
		else
			false
		end
	end 

    def mouse_over_ADD1(mouse_x, mouse_y)
        if ((mouse_x > 290 and mouse_x < 310) and (mouse_y > 680 and mouse_y < 700))
			    true
		    else
			    false
		    end
    end

    def mouse_over_ADD2(mouse_x, mouse_y)
        if ((mouse_x > 290 and mouse_x < 310) and (mouse_y > 700 and mouse_y < 720))
			    true
		    else
			    false
		    end
    end

    def mouse_over_ADD3(mouse_x, mouse_y)
        if ((mouse_x > 290 and mouse_x < 310) and (mouse_y > 720 and mouse_y < 740))
			    true
		    else
			    false
		    end
    end

    def mouse_over_home_button(mouse_x, mouse_y)
        if ((mouse_x > 1020 and mouse_x < 1170) and (mouse_y > 170 and mouse_y < 320))
			    true
		    else
			    false
		    end
    end

    def mouse_over_myfavourite(mouse_x, mouse_y)
        if ((mouse_x > 1020 and mouse_x < 1170) and (mouse_y > 20 and mouse_y < 170))
			    true
		    else
			    false
		    end
    end

    def mouse_over_button1(mouse_x, mouse_y)
        if ((mouse_x > 1130 and mouse_x < 1170) and (mouse_y > 390 and mouse_y < 430))
			    true
		    else
			    false
		    end
    end

    def mouse_over_button2(mouse_x, mouse_y)
        if ((mouse_x > 1130 and mouse_x < 1170) and (mouse_y > 430 and mouse_y < 470))
			    true
		    else
			    false
		    end
    end

    def mouse_over_genre_1(mouse_x, mouse_y)
        if ((mouse_x > 500 and mouse_x < 600) and (mouse_y > 45 and mouse_y < 120))
			    true
		    else
			    false
		    end
    end

    def mouse_over_genre_2(mouse_x, mouse_y)
        if ((mouse_x > 500 and mouse_x < 600) and (mouse_y > 140 and mouse_y < 220))
			    true
		    else
			    false
		    end
    end

    def mouse_over_volume_down(mouse_x, mouse_y)
        if ((mouse_x > 550 and mouse_x < 590) and (mouse_y > 740 and mouse_y < 780))
			    true
		    else
			    false
		    end
    end

    def mouse_over_volume_up(mouse_x, mouse_y)
        if ((mouse_x > 630 and mouse_x < 670) and (mouse_y > 740 and mouse_y < 780))
			    true
		    else
			    false
		    end
    end

    def mouse_over_pause(mouse_x, mouse_y)
        if ((mouse_x > 590 and mouse_x < 630) and (mouse_y > 740 and mouse_y < 780))
			    true
		    else
			    false
		    end
    end

    def mouse_over_cover(mouse_x, mouse_y)
        if ((mouse_x > 525 and mouse_x < 675) and (mouse_y > 300 and mouse_y < 450))
			    true
		    else
			    false
		    end
    end

    def mouse_over_fav_song(mouse_x, mouse_y)
      if ((mouse_x > 550 and mouse_x < 650) and (mouse_y > 300 and mouse_y < 350))
        true
      else
        false
      end 
    end

      def generate_song_album1
        case rand(3)
        when 0
          @tracks[0].play
        when 1
          @tracks[1].play
        when 2
          @tracks[2].play
        end
      end

      def generate_song_album2
        case rand(3)
        when 0
          @tracks[3].play
        when 1
          @tracks[4].play
        when 2
          @tracks[5].play
        end
      end

      def generate_song_album3
        case rand(3)
        when 0
          @tracks[6].play
        when 1
          @tracks[7].play
        when 2
          @tracks[8].play
        end
      end

      def generate_song_album4
        case rand(3)
        when 0
          @tracks[9].play
        when 1
          @tracks[10].play
        when 2
          @tracks[11].play
        end
      end

      def generate_song_album5
        case rand(3)
        when 0
          @tracks[12].play
        when 1
          @tracks[13].play
        when 2
          @tracks[14].play
        end
      end

      def generate_song_album6
        case rand(3)
        when 0
          @tracks[15].play
        when 1
          @tracks[16].play
        when 2
          @tracks[17].play
        end
      end

      def generate_song_album7
        case rand(3)
        when 0
          @tracks[18].play
        when 1
          @tracks[19].play
        when 2
          @tracks[20].play
        end
      end

      def generate_song_album8
        case rand(3)
        when 0
          @tracks[21].play
        when 1
          @tracks[22].play
        when 2
          @tracks[23].play
        end
      end

    def button_up(id)
        puts "In Button up " + id.to_s
        case id 
        when Gosu::MsLeft
            if mouse_over_home_button(mouse_x, mouse_y) or ((mouse_over_cover(mouse_x, mouse_y)) && (@page == -1))
              @page = 0
            end
            if mouse_over_button1(mouse_x, mouse_y)
              @page = 1
            end
            if mouse_over_button2(mouse_x, mouse_y)
              @page = 2
            end
            if mouse_over_myfavourite(mouse_x, mouse_y)
              @page = 3
            end

            if mouse_over_POP(mouse_x, mouse_y)
              @genre_selected = 1
            end
            if mouse_over_CLASSIC(mouse_x, mouse_y)
              @genre_selected = 2
            end
            if mouse_over_JAZZ(mouse_x, mouse_y)
              @genre_selected = 3
            end
            if mouse_over_ROCK(mouse_x, mouse_y)
              @genre_selected = 4
            end
            if mouse_over_pause(mouse_x, mouse_y)
              for i in 0..(@tracks.length-1)
                @tracks[i].pause
              end
            end
        end
        
    end

	def button_down(id)
        puts "In Button Down " + id.to_s
        case id
            when Gosu::KbEscape
            close     
            when Gosu::MsLeft
              if mouse_over_volume_down(mouse_x, mouse_y)
                if @volume > 0
                  for i in 0..(@tracks.length-1)
                  @tracks[i].volume -= 0.1
                  end
                end
              end 
              if mouse_over_volume_up(mouse_x, mouse_y)
                if @volume < 1
                  for i in 0..(@tracks.length-1)
                  @tracks[i].volume += 0.1
                  end
                end
              end 
			        if @selected_album == 1
		            if mouse_over_track1(mouse_x, mouse_y)
				          @tracks[0].play				 
			          end
			          if mouse_over_track2(mouse_x, mouse_y)
			            @tracks[1].play
			          end
			          if mouse_over_track3(mouse_x, mouse_y)
			            @tracks[2].play
			          end
			        end
			        if @selected_album == 2
		            if mouse_over_track1(mouse_x, mouse_y)
			            @tracks[3].play
			          end
			          if mouse_over_track2(mouse_x, mouse_y)
			            @tracks[4].play
			          end
			          if mouse_over_track3(mouse_x, mouse_y)
			            @tracks[5].play
			          end
			        end
	            if @selected_album == 3
				        if mouse_over_track1(mouse_x, mouse_y)
				          @tracks[6].play
				        end
				        if mouse_over_track2(mouse_x, mouse_y)
                  @tracks[7].play
				        end
				        if mouse_over_track3(mouse_x, mouse_y)
                  @tracks[8].play
				        end
			        end
			        if @selected_album == 4
				        if mouse_over_track1(mouse_x, mouse_y)
                  @tracks[9].play
				        end
				        if mouse_over_track2(mouse_x, mouse_y)
				          @tracks[10].play
				        end
				        if mouse_over_track3(mouse_x, mouse_y)
				          @tracks[11].play
				        end
              end
              if @selected_album == 5
                if mouse_over_track1(mouse_x, mouse_y)
                  @tracks[12].play
                end
                if mouse_over_track2(mouse_x, mouse_y)
                  @tracks[13].play
                end
                if mouse_over_track3(mouse_x, mouse_y)
                  @tracks[14].play
                end
              end
              if @selected_album == 6
                if mouse_over_track1(mouse_x, mouse_y)
                  @tracks[15].play
                end
                if mouse_over_track2(mouse_x, mouse_y)
                  @tracks[16].play
                end
                if mouse_over_track3(mouse_x, mouse_y)
                  @tracks[17].play
                end
              end
              if @selected_album == 7
                if mouse_over_track1(mouse_x, mouse_y)
                  @tracks[18].play
                end
                if mouse_over_track2(mouse_x, mouse_y)
                  @tracks[19].play
                end
                if mouse_over_track3(mouse_x, mouse_y)
                  @tracks[20].play
                end
              end
              if @selected_album == 8
                if mouse_over_track1(mouse_x, mouse_y)
                  @tracks[21].play
                end
                if mouse_over_track2(mouse_x, mouse_y)
                  @tracks[22].play
                end
                if mouse_over_track3(mouse_x, mouse_y)
                  @tracks[23].play
                end
              end
              if @page == 3
                if mouse_over_fav_song(mouse_x, mouse_y)
                  if @album_id == 1
                    if @track_id == 1
                      @tracks[0].play
                    elsif @track_id == 2
                      @tracks[1].play
                    elsif @track_id == 3
                      @tracks[2].play
                    end
                  end  
                  if @album_id == 2
                    if @track_id == 1
                      @tracks[3].play
                    elsif @track_id == 2
                      @tracks[4].play
                    elsif @track_id == 3
                      @tracks[5].play
                    end
                  end
                  if @album_id == 3
                    if @track_id == 1
                      @tracks[6].play
                    elsif @track_id == 2
                      @tracks[7].play
                    elsif @track_id == 3
                      @tracks[8].play
                    end
                  end
                  if @album_id == 4
                    if @track_id == 1
                      @tracks[9].play
                    elsif @track_id == 2
                      @tracks[10].play
                    elsif @track_id == 3
                      @tracks[11].play
                    end
                  end
                  if @album_id == 5
                    if @track_id == 1
                      @tracks[12].play
                    elsif @track_id == 2
                      @tracks[13].play
                    elsif @track_id == 3
                      @tracks[14].play
                    end
                  end
                  if @album_id == 6
                    if @track_id == 1
                      @tracks[15].play
                    elsif @track_id == 2
                      @tracks[16].play
                    elsif @track_id == 3
                      @tracks[17].play
                    end
                  end
                  if @album_id == 7
                    if @track_id == 1
                      @tracks[18].play
                    elsif @track_id == 2
                      @tracks[19].play
                    elsif @track_id == 3
                      @tracks[20].play
                    end
                  end
                  if @album_id == 8
                    if @track_id == 1
                      @tracks[21].play
                    elsif @track_id == 2
                      @tracks[22].play
                    elsif @track_id == 3
                      @tracks[23].play
                    end
                  end
                end
              end
                  if @page == 0
                    if @genre_selected == 1
                      if mouse_over_genre_1(mouse_x, mouse_y)
                        generate_song_album1
                      end
                      if mouse_over_genre_2(mouse_x, mouse_y)
                        generate_song_album2
                      end
                    end
                    if @genre_selected == 2
                      if mouse_over_genre_1(mouse_x, mouse_y)
                        generate_song_album3
                      end
                      if mouse_over_genre_2(mouse_x, mouse_y)
                        generate_song_album4
                      end
                    end
                    if @genre_selected == 3
                        if mouse_over_genre_1(mouse_x, mouse_y)
                          generate_song_album5
                        end
                        if mouse_over_genre_2(mouse_x, mouse_y)
                          generate_song_album6
                        end
                    end
                    if @genre_selected == 4
                        if mouse_over_genre_1(mouse_x, mouse_y)
                            generate_song_album7
                        end
                        if  mouse_over_genre_2(mouse_x, mouse_y)
                            generate_song_album8
                        end
                    end
                  end

		    end
	end
end

MusicPlayerMain.new.show if __FILE__ == $0
