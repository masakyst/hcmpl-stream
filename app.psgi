use strict;
use warnings;
use utf8;
use Plack::Builder;
use Tatsumaki::Application;
use IndexHandler;
use TweetHandler;
use YAML;

my $app = Tatsumaki::Application->new([
    qr'/(\d+)'      => 'IndexHandler',
    qr'/poll/(\d+)' => 'TweetHandler',
]);

$app->template_path( "template" );
$app->static_path( "static" );

$app->{config} = YAML::LoadFile('config.yml');

builder {
    enable "SimpleLogger", level => 'debug';
    $app;
};
