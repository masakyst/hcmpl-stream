use strict;
use warnings;
use utf8;
use Tatsumaki::Application;
use HtmlHandler;
use TweetHandler;
use TweetMockHandler;
use YAML;

my $app = Tatsumaki::Application->new([
    qr'/(\d+)'      => 'HtmlHandler',
    qr'/poll/(\d+)' => 'TweetHandler',
    #qr'/poll/(\d+)' => 'TweetMockHandler',
]);

$app->template_path( "template" );
$app->static_path( "static" );

$app->{config} = YAML::LoadFile('config.yml');

return $app;
