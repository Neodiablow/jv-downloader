#!/usr/bin/ruby -w
# -*- coding : utf-8 -*-


#Developper : F.DUPONT, L.EMMANUEL
#in ruby

addressJV=ARGV[0].to_s

puts addressJV

`wget #{addressJV} -O file1.html`

File.open("file1.html","r"){|file|
   File.foreach("file1.html") do |line|
        if line.chomp =~ /^<meta property="og:video" content="http:\/\/www.jeuxvideo.com\/videos\/chroniques\/iframe\/(\d+)" \/>$/
            puts "#{addressJV} a pour id #{$1}"
            addressIF="http://www.jeuxvideo.com/contenu/medias/video.php?q=config&id="+$1
            `wget "#{addressIF}" -O file2.html`
        end    
    end
}

File.open("file2.html","r"){|file|
   File.foreach("file2.html") do |line|
        #if line.chomp =~ /\{"label":"720p","file":"(.*.mp4)\}/
        if line.chomp =~ /(video720\.jeuxvideo\.com.+?.mp4)/
            addressVid="http://"+$1
            addressVid=addressVid.tr('\\','')
            puts addressVid
            `wget "#{addressVid}"`
        end    
    end
}
`rm file2.html file1.html #{addressJV}`
