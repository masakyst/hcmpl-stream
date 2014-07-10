package IndexHandler;

use Moo;

extends 'Tatsumaki::Handler';

use Data::Dumper;

sub get {
    my $self = shift;
    my ( $uid ) = @_;
    $self->render('index.html');
}

1;
