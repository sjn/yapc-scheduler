requires 'Data::GUID';
requires 'JSON::XS';
requires 'Path::Tiny';
requires 'Plack::Request';

on configure => sub {
    requires 'inc::Module::Install';
};
