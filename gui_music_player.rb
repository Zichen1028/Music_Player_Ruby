require 'rubygems'
require 'gosu'

TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
BOTTOM_COLOR = Gosu::Color.new(0xFF1D4DB5)

module ZOrder
  BACKGROUND, PAGE, UI = *0..2
end

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

$genre = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class ArtWork
	attr_accessor :bmp

	def initialize (file)
		@bmp = Gosu::Image.new(file)
	end
end

class Track
	attr_accessor :name, :location
	def initialize (name='', location='')
        @name = name
        @location = location
	end
end

class Album
	attr_accessor :title, :artist, :genre, :tracks
	def initialize (title='', artist='', genre='', tracks='')
        @title = title
        @artist = artist
        @genre = genre
        @tracks = tracks
	end
end


class MusicPlayerMain < Gosu::Window
	
	def initialize()
	    super 1200,800,false 
        self.caption = " "*90+"Music Player"
        @volume = 0.5
        @page = -1
        @selected_album = -1
        @genre_selected = 0
        @text = Gosu::Font.new(self,Gosu::default_font_name, 20)
        @albums = read_albums_file("media/albums.txt")
        @bg = Gosu::Image.new("picture/Cover.jpg")
        
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
        @button_home = Gosu::Image.new("picture/home.png")

        @song1 = Gosu::Song.new("media/cracklinrosie.mp3")
		@song2 = Gosu::Song.new("media/Soolaimon.mp3")
        @song3 = Gosu::Song.new("media/SweetCaroline.mp3")
        
		@song4 = Gosu::Song.new("media/Lemon.mp3")
		@song5 = Gosu::Song.new("media/Cranberry&Pancake.mp3")
        @song6 = Gosu::Song.new("media/PaperFlower.mp3")
        
		@song7 = Gosu::Song.new("media/HotelCalifornia.mp3")
		@song8 = Gosu::Song.new("media/NewKidinTown.mp3")
        @song9 = Gosu::Song.new("media/WastedTime.mp3")
        
		@song10 = Gosu::Song.new("media/Eraser.mp3")
		@song11 = Gosu::Song.new("media/Dive.mp3")
		@song12 = Gosu::Song.new("media/Shapeofyou.mp3")
        @song13 = Gosu::Song.new("media/Perfect.mp3")

        @song14 = Gosu::Song.new("media/BadRomance.mp3")
        @song15 = Gosu::Song.new("media/Alejandro.mp3")
        @song16 = Gosu::Song.new("media/LoveGame.mp3")
        @song17 = Gosu::Song.new("media/Applause.mp3")

        @song18 = Gosu::Song.new("media/TakeYourselfHome.mp3")
        @song19 = Gosu::Song.new("media/Youth.mp3")
        @song20 = Gosu::Song.new("media/LuckyStrike.mp3")
        @song21 = Gosu::Song.new("media/HappyLittlePill.mp3")

        @song25 = Gosu::Song.new("media/WhenIWasYourMan.mp3")
        @song26 = Gosu::Song.new("media/Treasure.mp3")
        @song27 = Gosu::Song.new("media/UptownFunk.mp3")

        @song22 = Gosu::Song.new("media/TreatYouBetter.mp3")
        @song23 = Gosu::Song.new("media/Mercy.mp3")
        @song24 = Gosu::Song.new("media/InMyBlood.mp3")        
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

  def draw_homepage()
    @text.draw("POP", 20, 20, 2, 5, 5, 0xff_FFD700)
    @text.draw("CLASSIC", 20, 140, 2, 5, 5, 0xff_FFD700)
    @text.draw("JAZZ", 20, 260, 2, 5, 5, 0xff_FFD700)
    @text.draw("ROCK", 20, 380, 2, 5, 5, 0xff_FFD700)
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
    
  def draw_button()
    @button_home.draw(1130,350,ZOrder::UI,0.1818,0.1818)
    @button1.draw(1130, 390,ZOrder::UI,0.2083,0.2083)
    @button2.draw(1130, 430,ZOrder::UI,0.2083,0.2083)
  end

  def setgui()
	  @album_color_status = Gosu::Color::YELLOW
	  @album_color_hover = Gosu::Color::YELLOW
  end

	def draw
        draw_background
        draw_button

        if @page == 0
           draw_homepage
        elsif @page == 1
           draw_albums_page1
        elsif @page == 2
           draw_albums_page2
        end
        
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
        
        if @page == 1
          if (mouse_over_track1(mouse_x, mouse_y)) && (Gosu::button_down?Gosu::MsLeft)
		   @selected_track = 1
		  end
		  if (mouse_over_track2(mouse_x, mouse_y)) && (Gosu::button_down?Gosu::MsLeft)
		     @selected_track = 2
		  end   
		  if (mouse_over_track3(mouse_x, mouse_y)) && (Gosu::button_down?Gosu::MsLeft)
		     @selected_track = 3
		  end
		  if (album4_clicked) && (mouse_over_track4(mouse_x, mouse_y)) && (Gosu::button_down?Gosu::MsLeft)
		     @selected_track = 4
          end
        end

        if @page == 2
            if (mouse_over_track1(mouse_x, mouse_y)) && (Gosu::button_down?Gosu::MsLeft)
             @selected_track = 1
            end
            if (mouse_over_track2(mouse_x, mouse_y)) && (Gosu::button_down?Gosu::MsLeft)
               @selected_track = 2
            end   
            if (mouse_over_track3(mouse_x, mouse_y)) && (Gosu::button_down?Gosu::MsLeft)
               @selected_track = 3
            end
            if (album1_clicked) && (mouse_over_track4(mouse_x, mouse_y)) && (Gosu::button_down?Gosu::MsLeft) or  (album2_clicked) && (mouse_over_track4(mouse_x, mouse_y)) && (Gosu::button_down?Gosu::MsLeft)
               @selected_track = 4
            end
        end
        
        if @page == 0
        for i in 0..(@albums.length-1)
            album = @albums[i]
            if album.genre == @genre_selected
                @text.draw("ALBUM GENRE: #{$genre[album.genre]}", 500, 20, 2, 1, 1, 0xff_FFD700)
                if (i == 0) or (i == 1)
                  draw_POP()
                  @text.draw("#{album.title}", 500 , 100 + i*100, 2, 1, 1, 0xff_FFD700)
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
        track = album.tracks[@selected_track.to_i - 1]
        height = 20
        @text.draw("Album: " + album.title, 20, 620, 2, 1.0, 1.0, 0xff_FFD700)
        @text.draw("Artist: " + album.artist, 20, 645, 2, 1.0, 1.0, 0xff_FFD700) 
        @text.draw("Track <#{track.name}> from album <#{album.title}> now is playing...", 400, 650, 2, 1.0, 1.0, 0xff_FFD700)
        for index in 0..(album.tracks.length-1)
            track = album.tracks[index]
            @text.draw("Track#{index+1}: " + track.name, 20, 680 + height*index, 2, 1.0, 1.0, 0xff_FFD700)
        end 
        end
	end

	 def needs_cursor?; true; end
	 
#______________________________album________________________#
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
        if ((mouse_x > 20 and mouse_x < 400) and (mouse_y > 20 and mouse_y < 120))
          true
        else
          false
        end
    end

    def mouse_over_CLASSIC(mouse_x, mouse_y)
        if ((mouse_x > 20 and mouse_x < 400) and (mouse_y > 140 and mouse_y < 240))
          true
        else
          false
        end
    end

    def mouse_over_JAZZ(mouse_x, mouse_y)
        if ((mouse_x > 20 and mouse_x < 400) and (mouse_y > 260 and mouse_y < 360))
          true
        else
          false
        end
    end

    def mouse_over_ROCK(mouse_x, mouse_y)
        if ((mouse_x > 20 and mouse_x < 400) and (mouse_y > 380 and mouse_y < 480))
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

    def pause
        if Gosu::button_down? Gosu::KbSpace
        self.Gosu::Song.pause
        end
    end

	#________________________track__________________#
	def mouse_over_track1(mouse_x, mouse_y)
		if ((mouse_x > 20 and mouse_x < 400 ) and (mouse_y > 680 and mouse_y < 700))
			true
		else
			false
		end
	end

    def mouse_over_track2(mouse_x, mouse_y)
		if ((mouse_x > 20 and mouse_x < 400) and (mouse_y > 700 and mouse_y < 720))
			true
		else
			false
		end
	end
	
	def mouse_over_track3(mouse_x, mouse_y)
		if ((mouse_x > 20 and mouse_x < 400) and (mouse_y > 720 and mouse_y < 740))
			true
		else
			false
		end
	end
	
	def mouse_over_track4(mouse_x, mouse_y)
		if ((mouse_x > 20 and mouse_x < 400) and (mouse_y > 740 and mouse_y < 760))
			true
		else
			false
		end
    end  

    def mouse_over_home_button(mouse_x, mouse_y)
        if ((mouse_x > 1130 and mouse_x < 1170) and (mouse_y > 350 and mouse_y < 390))
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

    def generate_song_album1
        case rand(3)
        when 0
          @song1.play
        when 1
          @song2.play
        when 2
          @song3.play
        end
      end

      def generate_song_album2
        case rand(3)
        when 0
          @song4.play
        when 1
          @song5.play
        when 2
          @song6.play
        end
      end

      def generate_song_album3
        case rand(3)
        when 0
          @song7.play
        when 1
          @song8.play
        when 2
          @song9.play
        end
      end

      def generate_song_album4
        case rand(4)
        when 0
          @song10.play
        when 1
          @song11.play
        when 2
          @song12.play
        when 3
          @song13.play
        end
      end

      def generate_song_album5
        case rand(4)
        when 0
          @song14.play
        when 1
          @song15.play
        when 2
          @song16.play
        when 3
          @song17.play 
        end
      end

      def generate_song_album6
        case rand(4)
        when 0
          @song18.play
        when 1
          @song19.play
        when 2
          @song20.play
        when 3
          @song21.play
        end
      end

      def generate_song_album7
        case rand(3)
        when 0
          @song22.play
        when 1
          @song23.play
        when 2
          @song24.play
        end
      end

      def generate_song_album8
        case rand(3)
        when 0
          @song25.play
        when 1
          @song26.play
        when 2
          @song27.play
        end
      end

    def button_up(id)
        puts "In Button up " + id.to_s
        case id 
        when Gosu::MsLeft
            if mouse_over_button1(mouse_x, mouse_y)
              @page = 1
            elsif mouse_over_button2(mouse_x, mouse_y)
              @page = 2
            elsif mouse_over_home_button(mouse_x, mouse_y)
              @page = 0
            elsif mouse_over_POP(mouse_x, mouse_y)
              @genre_selected = 1
            elsif mouse_over_CLASSIC(mouse_x, mouse_y)
              @genre_selected = 2
            elsif mouse_over_JAZZ(mouse_x, mouse_y)
              @genre_selected = 3
            elsif mouse_over_ROCK(mouse_x, mouse_y)
              @genre_selected = 4
            end
        end
    end

	def button_down(id)
		puts "In Button Down " + id.to_s
        case id
            when Gosu::KbEscape
            close
            when Gosu::KbUp
                if @volume < 1
                  @song1.volume += 0.1
                end
            when Gosu::KbDown
                if @volume > 0
                    @song1.volume -= 0.1
                end
		    when Gosu::MsLeft
			    if @selected_album == 1
		           if mouse_over_track1(mouse_x, mouse_y)
				   @song1.play				 
			       end
			       if mouse_over_track2(mouse_x, mouse_y)
			       @song2.play
			       end
			       if mouse_over_track3(mouse_x, mouse_y)
			       @song3.play
			       end
			    end
			    if @selected_album == 2
		           if mouse_over_track1(mouse_x, mouse_y)
			          @song4.play
			        end
			        if mouse_over_track2(mouse_x, mouse_y)
			           @song5.play
			        end
			        if mouse_over_track3(mouse_x, mouse_y)
			           @song6.play
			        end
			    end
	            if @selected_album == 3
				   if mouse_over_track1(mouse_x, mouse_y)
				      @song7.play
				   end
				   if mouse_over_track2(mouse_x, mouse_y)
				      @song8.play
				   end
				   if mouse_over_track3(mouse_x, mouse_y)
				      @song9.play
				   end
			    end
			    if @selected_album == 4
				   if mouse_over_track1(mouse_x, mouse_y)
				      @song10.play
				   end
				   if mouse_over_track2(mouse_x, mouse_y)
				      @song11.play
				   end
				   if mouse_over_track3(mouse_x, mouse_y)
				      @song12.play
				   end
				   if mouse_over_track4(mouse_x, mouse_y)
					  @song13.play
				   end
                end
                if @selected_album == 5
                    if mouse_over_track1(mouse_x, mouse_y)
                       @song14.play
                    end
                    if mouse_over_track2(mouse_x, mouse_y)
                       @song15.play
                    end
                    if mouse_over_track3(mouse_x, mouse_y)
                       @song16.play
                    end
                    if mouse_over_track4(mouse_x, mouse_y)
                       @song17.play
                    end
                 end
                 if @selected_album == 6
                    if mouse_over_track1(mouse_x, mouse_y)
                       @song18.play
                    end
                    if mouse_over_track2(mouse_x, mouse_y)
                       @song19.play
                    end
                    if mouse_over_track3(mouse_x, mouse_y)
                       @song20.play
                    end
                    if mouse_over_track4(mouse_x, mouse_y)
                       @song21.play
                    end
                 end
                 if @selected_album == 7
                    if mouse_over_track1(mouse_x, mouse_y)
                       @song22.play
                    end
                    if mouse_over_track2(mouse_x, mouse_y)
                       @song23.play
                    end
                    if mouse_over_track3(mouse_x, mouse_y)
                       @song24.play
                    end
                 end
                 if @selected_album == 8
                    if mouse_over_track1(mouse_x, mouse_y)
                       @song25.play
                    end
                    if mouse_over_track2(mouse_x, mouse_y)
                       @song26.play
                    end
                    if mouse_over_track3(mouse_x, mouse_y)
                       @song27.play
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
