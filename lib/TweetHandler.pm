package TweetHandler;

use JSON::XS;
use Moo;
use AnyEvent::Twitter::Stream;
use Tatsumaki::MessageQueue;
use Tatsumaki::Error;
use Data::Dumper;

extends 'Tatsumaki::Handler';
__PACKAGE__->asynchronous(1);

my %streams;

sub create_stream {
    my $self = shift;
    my ( $uid ) = @_;
    my $config = $self->{application}->{config};

    my $cs_key    = $config->{cs_key};
    my $cs_secret = $config->{cs_secret};
    my $ac_token  = $config->{ac_token};
    my $ac_secret = $config->{ac_secret};
    my $track     = $config->{track};

    my $mq = Tatsumaki::MessageQueue->instance( $uid );

    $streams{ $uid } ||= AnyEvent::Twitter::Stream->new(
        consumer_key    => $cs_key,
        consumer_secret => $cs_secret,
        token           => $ac_token,
        token_secret    => $ac_secret,
        method          => 'filter',
        track           => $track,
        #no_decode_json  => 1,
        on_keepalive => sub {
            warn "ping\n";
        },  
        on_tweet => sub {
            my $tweet = shift;
            print Dumper($tweet);
            $mq->publish( { type => 'tweet', tweet => $tweet, } );
        },
        on_error => sub {
            my $error = join ',', @_;
            print Dumper($error);
            $mq->publish( { type => 'message', text => $error, } );
            delete $streams{ $uid };
        },
        on_eof   => sub {
            $mq->publish( { type => 'message', text => 'disconnected', } );
            delete $streams{ $uid };
        },
        on_json => sub {
            my $json = shift;
            $mq->publish( { type => 'tweet', tweet => $json, } );
        },
 
    );
}

sub get {
    my $self = shift;
    my ( $uid ) = @_;

    my $session = $self->request->param('session')
        or Tatsumaki::Error::HTTP->throw(500, "'session' needed");

    $streams{ $uid } or $self->create_stream( $uid );
    my $mq = Tatsumaki::MessageQueue->instance( $uid );
    $mq->poll_once( $session, sub {
            my @events_published = @_;
            $self->write( \@events_published );
        $self->finish;
    } );
}

1;
