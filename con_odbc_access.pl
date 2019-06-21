#!/usr/bin/perl


use warnings;
use strict;
use DBI;
use DBD::ODBC;

#注意:这里的Employee是你刚才填数据源时填入的名字


sub img_grab{
		my $file = shift ;
		open my $fh,"<",$file or die "This file is not exsit!\n";
		
		binmode $fh;
		read $fh,my $img, -s $file;
		close $fh;
		return $img;
}

sub update_blob{
	my ($num,$pic) = @_;
	my $username = "";
	my $pwd = "hnsi";
	my $dbh = DBI->connect("DBI:ODBC:hnfinger", $username, $pwd) or 
		die("Couldn't make connection to database:$DBI::errstr");
		#$dbh->{LongTruncOk}=0;
	my $sth = $dbh->prepare("update photo 
		set photo=?
		where personno=?
		");
		$sth->bind_param(1, $pic, DBI::SQL_LONGVARBINARY);
		$sth->bind_param(2, $num);
		$sth->execute();
		#$dbh->commit();
		$dbh->disconnect;
		
}
=pod
sub fetch_blob{
	my $num = shift;
	my $username = "";
	my $pwd = "hnsi";
	my $dbh = DBI->connect("DBI:ODBC:hnfinger", $username, $pwd) or 
		die("Couldn't make connection to database:$DBI::errstr");
		my $size=-s "D:/111.jpg";
		print "$size\n";
		$dbh->{LongReadLen}= $size;
	my $sth = $dbh->prepare(
		"select photo 
		from photo
		where personno=?
		");
		
		$sth->execute($num);
		my @records = $sth->fetchrow_array();
		$dbh->disconnect;
		return $records[0];
	}
=cut
while (<>){
	chomp;
	my @arr = split (/,/);
	
	# my $grbh=$arr[0];
	# my $file=$arr[1];
	# print "$grbh,$file\n";
	# $_ = $_[1]
	#open FH,">","114.jpg";
	#binmode FH;
	
	my $photo = img_grab ($arr[1]);
	
	
	update_blob($arr[0],$photo);
	#my $blob=fetch_blob($arr[0]);
	#print FH $blob;
	#close FH;
}
	
