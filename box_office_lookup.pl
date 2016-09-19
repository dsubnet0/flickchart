#!/usr/bin/perl

use v5.10;
use strict;
use warnings;
use Data::Dumper;

my $file = $ARGV[0];

open FILE, $file;

my $i=0;
while (<FILE>) {
  next unless $i++;
  #print "LINE: ".$_; 
  my @line = split ',';
  my $title =  $line[1]; 
  $title =~ s/ /\+/g;
  say "$title,".getRank($title);
}

sub getRank {
  my $title = shift;
  my $url = "www.flickchart.com".getUrl($title);
  say "URL: $url";
  my $result = `curl $url|grep '<meta id="ctl00_ctl00_head_head_movieMetaDescription"'`;
  my @result = split('\#', $result);
  exit;

}

sub getUrl {
  my $title = shift;
  say "TITLE = $title";
  my $result = `curl -s www.flickchart.com/searchResults.aspx?s=$title|grep '<a href="/movie/'`;
  my @result = split('\n',$result);
  my $line = $result[0];
  my @line = split('"',$line);
  return $line[1];
}
