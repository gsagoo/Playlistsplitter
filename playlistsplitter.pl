#!/usr/bin/perl
use warnings FATAL => 'all';
use strict;

# This script parses a .pls music playlist file and attempts to read the artist and song title and pathname
# The script then outputs  4 files artists.txt, songnames.txt, paths.txt and cdname.txt which can then be used to catalogue 
# the music files into a database file like .csv 
# Run the script with the following command:
#
# perl playlistsplitter.pl myplaylist1.pls 
# or 
# perl playlistsplitter.pl myplaylist1.pls myplaylist2.pls

my ($line, @parts_matched, $CDname,$thefilename,$thefilepath,$icounter);

#Opening files for writing
open FPath, ">paths.txt" or die "Couldn't open file paths.txt";
open FSongnames, ">songnames.txt" or die "Couldn't open file songnames.txt";
open FArtists, ">artists.txt" or die "Couldn't open file artists.txt";
open FCDname, ">cdname.txt" or die "Couldn't open file cdname.txt";

#Print out the list of files that this script is going to read
print STDERR "@ARGV\n";

#Cycle through each file that is a playlist
for( $icounter = 0; $icounter < @ARGV ; $icounter++)
{
	open (LOG, "<$ARGV[$icounter]");
	$CDname = "Initialising CD name";
	print STDERR "Enter the name of the CD (anything will do):";
	$CDname = <STDIN>;
	chomp($CDname);
	while (<LOG>) #Iterations over each line of the file
		{
	    	$line = $_;
        	chomp($line);
			if($line =~ m "^File(\d+)=(.*/|\\)(.*)") #Match a line starting with File upto last slash
        		{
				#The parts of the line read from file are now pattern matched and stored in parts_matched array
				# $1=filenumber $2=path and $3=filename of each music file.
            	@parts_matched = ($1,$2,$3,$3,$3);  #Any array containing matched parts from the regex
				$thefilepath = $2;
				$thefilename = $3;
				print FPath "$thefilepath\n";
				print STDERR "$thefilename\n";
				print FCDname "$CDname\n";

				if( $thefilename =~ m "(.*)-([\s\w]*)") #Match any character upto the last hyphen which must be followed by alphanumeric characters and spaces
				{
					$parts_matched[3] = $1;
					$parts_matched[4] = $2;
					
				}
				elsif($thefilename =~ m "(([\w]*\s){1,2})(.*)\.\w+" ) #Match the first two words followed by a string which terminates in a dot followed by alphanumerics
				{
					$parts_matched[3] = $1;
					$parts_matched[4] = $3;
				}
				#More pattern checks could be conducted by extending this elsif statement however for those who want to experiment with regex this is left as an experiment!
				print FArtists "$parts_matched[3]\n";
				print FSongnames "$parts_matched[4]\n";
			}
		}
	close(LOG);
	print STDERR "$ARGV[$icounter] \n";
}
close(FPath);
close(FSongnames);
close(FArtists);
close(FCDname);
print STDERR "Script ended \n";
exit 1;
