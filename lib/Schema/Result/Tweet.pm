package Schema::Result::Tweet;
use strict;
use warnings;
use base 'DBIx::Class::Core';

__PACKAGE__->table('tweet');
__PACKAGE__->add_columns(qw/id screen_name tweet created_at/);
__PACKAGE__->set_primary_key('id');

1;

