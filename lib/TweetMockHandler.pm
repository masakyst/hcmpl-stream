package TweetMockHandler;

use Moo;
use AnyEvent::Twitter::Stream;
use Tatsumaki::MessageQueue;
use Tatsumaki::Error;

extends 'Tatsumaki::Handler';
__PACKAGE__->asynchronous(1);

my %streams;

sub create_stream {
    my $self = shift;
    my ( $uid ) = @_;
    my $mq = Tatsumaki::MessageQueue->instance( $uid );
    $streams{ $uid } ||= 'AnyEvent::Twitter::Stream';
}


sub get {
    my $self = shift;
    my ( $uid ) = @_;

    my $session = $self->request->param('session')
                     or Tatsumaki::Error::HTTP->throw(500, "'session' needed");

    $streams{ $uid } or $self->create_stream( $uid );
    my $mq = Tatsumaki::MessageQueue->instance( $uid );

    my $tweet = +{};
    $tweet->{user}->{screen_name} = 'masakyst';
    $tweet->{text} = 'aaaaaaaaaaa';

    $mq->publish( { type => 'tweet', tweet => $tweet, } );
    sleep 3;
    $mq->poll_once( $session, sub {
        my @events_published = @_;
        $self->write( \@events_published );
        $self->finish;
    } );

}

1;
