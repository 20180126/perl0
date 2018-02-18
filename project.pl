#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use CGI;
use open ":utf8";
use open IO => qw/:encoding(UTF-8)/;
binmode STDOUT, ':encoding(UTF-8)';

print qq(Content-type: text/html\n\n);
print <<END;
    <html lang="ja">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Document</title>
        <link rel="stylesheet" href="./style.css">
    </head>
    <body>
        <div class="container">
        <div class="section">Source</div>
    </div>
    <div class="source_code">
    <pre class="prettyprint" id="custom">
END

# ファイル名を取得
chdir("/var/www/html");
my @file = glob "*.*";
my $length = @file;

for(my $l = 0; $l < $length; $l++){

    # ファイル更新日時を取得
    my ($sec, $min, $hour, $mday, $mon, $year) = localtime((stat(@file[$l]))[9]);
    $year += 1900;
    $mon++;
    my $optionStr = $year."/".$mon."/".$mday." ".$hour.":".$min.":".$sec;

    # ファイル名を表示
    print "<div id='".@file[$l]."' class='project_source'>";
    print @file[$l]."\t".$optionStr;
    print "</div>";
}

# UTF-8で出力
my $cgi = new CGI;
$cgi->charset('utf-8');

for(my $i = 0; $i < $length; $i++){

    print "<div class='hidden_source' id='source_".@file[$i]."'>";
    open(DATAFILE, @file[$i]) or die("Error:$!");
    while(my $line = <DATAFILE>){
        print $cgi->escapeHTML($line);
    }
    print "</div>";
}

print <<START;
    </pre>
    </div>
    </body>
    <script src="https://cdn.rawgit.com/google/code-prettify/master/loader/run_prettify.js"></script>
    <script src="./script.js"></script>
    </html>
START
