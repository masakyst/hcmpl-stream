#!/bin/bash

cpanm Plack --notest
cpanm -L extlib git://github.com/miyagawa/AnyEvent-Twitter-Stream.git
cpanm -L extlib JSON::XS --notest
cpanm -L extlib YAML --notest
cpanm -L extlib Twiggy --notest
cpanm -L extlib Tatsumaki --notest
cpanm -L extlib Net::SSLeay --notest
cpanm -L extlib Net::OAuth --notest
