package HtmlHandler;

use Moo;

extends 'Tatsumaki::Handler';

sub get {
    my $self = shift;
    my ( $uid ) = @_;
    $self->render('index.html');
}

1;
