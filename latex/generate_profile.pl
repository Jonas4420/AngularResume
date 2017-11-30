#!/usr/bin/perl

use strict;
use warnings;

use JSON;

sub ltx_cmd        { my ($tag) = @_; return "\\$tag"; } 
sub ltx_open       { return "{"; } 
sub ltx_close      { return "}"; }
sub ltx_nl         { return "\\\\"; }
sub ltx_space      { return ltx_nl . "[\\cvspace]"; }
sub ltx_smallspace { return ltx_nl . "[\\cvsmallspace]"; }
sub ltx_tab        { return "    "; }

sub ltx_txt
{
	my ($txt) = @_;
	$txt =~ s/\x{2013}/--/g;
	$txt =~ s/&/\\&/g;
	return $txt;
}

sub ltx_degree
{
	my ($ed) = @_;
	my $result = "";

	$result .= ltx_cmd("sbdegree");
	$result .= ltx_open . ltx_txt($ed->{name})       . ltx_close;
	$result .= ltx_open . ltx_txt($ed->{grade})      . ltx_close;
	$result .= ltx_open . ltx_txt($ed->{university}) . ltx_close;
	$result .= ltx_open . ltx_txt($ed->{country})    . ltx_close;
	$result .= ltx_open . ltx_txt($ed->{start})      . ltx_close;
	$result .= ltx_open . ltx_txt($ed->{end})        . ltx_close;

	return $result 
}

sub ltx_language
{
	my ($lang) = @_;
	my $result = "";

	$result .= ltx_cmd("sblang");
	$result .= ltx_open . ltx_txt($lang->{name}) . ":" . ltx_close;
	$result .= " ";
	$result .= ltx_cmd("sbdesc");
	$result .= ltx_open . ltx_txt($lang->{level}) . ltx_close;

	return $result;
}

sub ltx_interest
{
	my ($int) = @_;
	my $result = "";

	$result .= ltx_cmd("sbtext");
	$result .= ltx_open . ltx_txt($int) . ltx_close;

	return $result;
}

sub ltx_experience
{
	my ($exp) = @_;
	my $result = "";

	my $date = "";
	if ( defined $exp->{end} && $exp->{end} ne "" ) {
		$date = $exp->{start} . " \x{2013} " . $exp->{end};
	} else {
		$date = "Since " . $exp->{start};
	}

	$result .= ltx_cmd("cvexp");
	$result .= ltx_open . ltx_txt($exp->{name})     . ltx_close;
	$result .= ltx_open . ltx_txt($date)            . ltx_close;
	$result .= ltx_open . ltx_txt($exp->{company})  . ltx_close;
	$result .= ltx_open . ltx_txt($exp->{location}) . ltx_close;
	$result .= "\n";

	$result .= ltx_tab . ltx_cmd("cvexpdesc") . ltx_open . "\n";
	for ( @{$exp->{details}} ) {
		$result .= ltx_tab . ltx_tab . ltx_cmd("item") . " ";
		$result .= ltx_txt($_);
		$result .= "\n";
	}
	$result .= ltx_tab . ltx_close;

	return $result; 
}

sub ltx_skill
{
	my ($sk) = @_;
	my $result = "";

	$result .= ltx_cmd("cvskill");
	$result .= ltx_open . ltx_txt($sk->{name}) . ltx_close . ltx_nl . "\n";

	$result .= ltx_tab;
	for ( @{$sk->{items}} ) {
		$result .= ltx_txt($_);
		$result .= " " . ltx_cmd("cvbullet") . " " if $_ ne $sk->{items}->[-1];
	}

	return $result; 
}

sub ltx_profile
{
	my ($profile) = @_;
	my $result = "";

	$result .= ltx_cmd("cvprofile")  . ltx_open . ltx_txt($profile->{picture})  . ltx_close . "\n";
	$result .= ltx_cmd("cvname")     . ltx_open . ltx_txt($profile->{name})     . ltx_close . "\n";
	$result .= ltx_cmd("cvjobtitle") . ltx_open . ltx_txt($profile->{jobtitle}) . ltx_close . "\n";
	$result .= "\n";

	$result .= ltx_cmd("cvemail")    . ltx_open . ltx_txt($profile->{email})    . ltx_close . "\n";
	$result .= ltx_cmd("cvphone")    . ltx_open . ltx_txt($profile->{phone})    . ltx_close . "\n";
	$result .= ltx_cmd("cvaddress")  . ltx_open . ltx_txt($profile->{address})  . ltx_close . "\n";
	$result .= ltx_cmd("cvcity")     . ltx_open . ltx_txt($profile->{city})     . ltx_close . "\n";
	$result .= ltx_cmd("cvcountry")  . ltx_open . ltx_txt($profile->{country})  . ltx_close . "\n";
	$result .= ltx_cmd("cvlinkedin") . ltx_open . ltx_txt($profile->{linkedin}) . ltx_close . "\n";
	$result .= ltx_cmd("cvgithub")   . ltx_open . ltx_txt($profile->{github})   . ltx_close . "\n";
	$result .= "\n";

	$result .= ltx_cmd("cvdegrees") . ltx_open . "\n";
	for ( @{$profile->{education}} ) {
		$result .= ltx_tab;
		$result .= ltx_degree($_);
		$result .= ltx_space if $_ != $profile->{education}->[-1];
		$result .= "\n";
	}
	$result .= ltx_close . "\n";
	$result .= "\n";

	$result .= ltx_cmd("cvlanguages") . ltx_open . "\n";
	for ( @{$profile->{languages}} ) {
		$result .= ltx_tab;
		$result .= ltx_language($_);
		$result .= ltx_space if $_ != $profile->{languages}->[-1];
		$result .= "\n";
	}
	$result .= ltx_close . "\n";
	$result .= "\n";

	$result .= ltx_cmd("cvinterests") . ltx_open . "\n";
	for ( @{$profile->{interests}} ) {
		$result .= ltx_tab;
		$result .= ltx_interest($_);
		$result .= ltx_space if $_ ne $profile->{interests}->[-1];
		$result .= "\n";
	}
	$result .= ltx_close . "\n";
	$result .= "\n";

	$result .= ltx_cmd("cvabout") . ltx_open . "\n";
	$result .= ltx_txt($profile->{about});
	$result .= "\n";
	$result .= ltx_close . "\n";
	$result .= "\n";

	$result .= ltx_cmd("cvexperiences") . ltx_open . "\n";
	for ( @{$profile->{experiences}} ) {
		$result .= ltx_tab;
		$result .= ltx_experience($_);
		$result .= "\\ \n" if $_ ne $profile->{experiences}->[-1];
		$result .= "\n";
	}
	$result .= ltx_close . "\n";
	$result .= "\n";

	$result .= ltx_cmd("cvskills") . ltx_open . "\n";
	if ( defined $profile->{programming} ) {
		$result .= ltx_tab;
		$result .= ltx_cmd("cvskill");
		$result .= ltx_open . ltx_txt("Programming Languages") . ltx_close . ltx_nl . "\n";

		my $max = 0;
		for ( @{$profile->{programming}} ) {
			$max = length($_->{name}) if length($_->{name}) > $max;
		}

		for ( @{$profile->{programming}} ) {
			$result .= ltx_tab;
			$result .= $_->{name};
			$result .= " " x ($max - length($_->{name}));
			$result .= " " . ltx_cmd("hfill") . " ";
			$result .= ltx_cmd("cvskillbar");
			$result .= ltx_open . ltx_txt($_->{level}) . ltx_close;
			$result .= ltx_open . ltx_txt("cv-green") . ltx_close;

			$result .= ltx_smallspace if $_ ne $profile->{programming}->[-1];
			$result .= ltx_nl         if $_ eq $profile->{programming}->[-1];

			$result .= "\n";
		}

		$result .= "\n";
	}

	for ( @{$profile->{skills}} ) {
		$result .= ltx_tab;
		$result .= ltx_skill($_);
		$result .= ltx_nl . "\n" if $_ ne $profile->{skills}->[-1];
		$result .= "\n";
	}
	$result .= ltx_close . "\n";

	return $result;
}

sub main
{
	my $input_file  = shift(@ARGV) or die "Input JSON file is not provided...\n";
	my $output_file = shift(@ARGV) or die "Output LaTeX file is not provided...\n";

	open ( my $input_fh, "<:encoding(UTF-8)", $input_file ) or die "$input_file: $!";
	my $profile = from_json(do { local $/ = undef; <$input_fh> });
	close ( $input_fh );

	open ( my $output_fh, ">:encoding(UTF-8)", $output_file ) or die "$output_file: $!";
	print $output_fh ltx_profile($profile);
	close ( $output_fh );

	exit(0);
}

main();

1;
