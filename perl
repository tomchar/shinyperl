Skip to content
Features Explore Pricing
This repository
Search
Sign in or Sign up
 Watch 1  Star 1  Fork 1 joey0214/Perl
 Code  Issues 0  Pull requests 0  Projects 0  Pulse  Graphs
Branch: master Find file Copy pathPerl/getMultiSeqFromNCBIByAcc.pl
a30bde3  on Dec 17, 2013
@joey0214 joey0214 20131218
1 contributor
RawBlameHistory     
39 lines (35 sloc)  1.09 KB
#!usr/bin/local/perl -w
#@author :joey
#@version:2012-05-10
#usage: perl get_multi_seq_fromNCBI_by_acc.pl acc_file.txt fasta[genbank]
#use this program,can get seq by accession number from NCBI,and name it by acc.
#$ARGV[0]=acc.txt

use strict;
use Bio::DB::GenBank;
use Bio::SeqIO;
use Bio::Seq::RichSeq;

open(FILE,$ARGV[0])|| die ("can  not open file:$!");
my @acc=<FILE>;

my $db=new Bio::DB::GenBank();
my $allseq=$db->get_Stream_by_acc([@acc]);
while(my $seq=$allseq->next_seq){
  #my $filename=$seq->accession;
    my $output;
	if ($ARGV[1] eq "fasta" | $ARGV[1] eq "FASTA"){
		$output = new Bio::SeqIO(-file=>">>output.fasta",-format=>"fasta");
	}
	if ($ARGV[1] eq "genbank" | $ARGV[1] eq "GENBANK"){
		$output = new Bio::SeqIO(-file=>">>output.gb",-format=>"genbank");
	}
	#my $output = new Bio::SeqIO(-file=>">>output.fasta",-format=>"fasta");
	#if you want fasta seq,can use next
	#my $output = new Bio::SeqIO(-file=>">$filename.gb",-format=>"genbank");
	if($seq){
		$output->write_seq($seq);
	}
	else{
		print STDERR "cannot find sequence for accession number:@acc \n";
	}
	$output ->close();
}
close(FILE);
Contact GitHub API Training Shop Blog About
© 2017 GitHub, Inc. Terms Privacy Security Status Help
