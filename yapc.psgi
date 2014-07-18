use strict; use warnings;
use Plack::Request;
use JSON::XS;
use Data::Dumper;
use Data::GUID;
use Path::Tiny;

sub {
    my $env = shift;
    my $req = Plack::Request->new($env);


    if (my $json = $req->param('json')) {
        my $guid = Data::GUID->new->as_string;

        # yeah, we're basically saving anything at all. Hello DOS attacks!
        path('data', $guid)->spew($json);

        my $res = $req->new_response(200);
        $res->content_type('text/plain');
        $res->body($guid);
        warn "SENDING $guid";
        return $res->finalize;
    }
    elsif (my $query = $req->param('query')) {
        my $res = $req->new_response(200);
        $res->content_type('application/json');
        $res->body( path('data', $query)->slurp );
        return $res->finalize;
    }
    else {
        my $res = $req->new_response(200);
        $res->content_type('text/html');
        $res->body( path('index.html')->slurp );
        return $res->finalize;

    }

};
