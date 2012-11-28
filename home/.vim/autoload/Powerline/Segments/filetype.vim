let g:Powerline#Segments#filetype#segments = Pl#Segment#Init(['filetype',
	\ Pl#Segment#Create('filetype', '%{strlen(&ft) ? &ft : "none"}', Pl#Segment#Modes('!N'))
\ ])
