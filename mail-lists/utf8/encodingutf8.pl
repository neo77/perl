#!/usr/bin/perl 
#APos: APosDoc=1.3
#* Name: encodingutf8.pl
#* Info: utf8 encoding problem
#* Author: Michael.Ludwig
#*
#* It seems that (a) and (b) do not handle the \x{....} notation
#* identically as far as the Latin-1 Supplement (U+0080 to U+00FF)
#* is concerned. (Tried Perl 5.8.9 and 5.10.0.) What do you think?
#*


use strict;
use warnings;

#=------------------------------------------------------------------------ USE, CONSTANTS..

use FindBin qw/$Bin/;
use lib $Bin."/../../../";

use Data::Dumper;		# FIXME Debug only


#=------------------------------------------------------------------------ FUNCTIONS



#=------------------------------------------------------------------------ main()

# use either (a)
use utf8; binmode STDOUT, ':utf8';	# test a
# or (b) to test
#use encoding 'utf8';		# test b

my @strings = (
 "These should print okay on a UTF-8 terminal",
 "disposing of the relevant glyphs:",
 "\t\x{041c}\x{0438}\x{0440} - Russian space station", # Мир
 "\tKäse - UTF-8 literal",
 '---------------',
 'Same for these:',
 "\tK\x{e4}se - Unicode character escape \\x{e4}",
 "\tK\x{00e4}se - \\x{00e4}, same thing",
 '---------------',
 'These should be double-encoded on a UTF-8 terminal:',
 "\tK\x{c3}\x{a4}se - octets \\x{c3}\\x{a4}",
 "\tK\xc3\xa4se - octets \\xc3\\xa4",
);

print "$_\n" for @strings;

