# Playlistsplitter
Perl script that splits a music pls file (Linux format) into artist and songtitles text files.
A demonstration playlist is available with the splitter and is called 'defaultmusicplaylist.pls'.
The file will output 4 files: artists.txt, songnames.txt, paths.txt and cdname.txt. 

You may run the script with the following command 
  ```
  perl playlistsplitter.pl defaultmusicplaylist.pls
  ```
 
There are many improvements needed for this code, it was merely written for the illustration of 
reading a file, writing a file and pattern matching using perl regex.
