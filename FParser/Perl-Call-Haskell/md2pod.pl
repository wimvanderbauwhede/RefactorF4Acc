use Markdown::Pod;
open my $MD, '<', 'README.md';
my $markdown='';
while (my $line=<$MD>) {
$markdown.=$line;
}
close $MD;
my $m2p = Markdown::Pod->new;
my $pod = $m2p->markdown_to_pod(
            markdown => $markdown,
        );

print $pod;

