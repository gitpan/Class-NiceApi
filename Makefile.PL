use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Class::NiceApi',
    'VERSION_FROM'	=> 'NiceApi.pm', # finds $VERSION
    'PREREQ_PM'		=> { Class::Maker => 0 }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM => 'NiceApi.pm', # retrieve abstract from module
       AUTHOR     => 'Murat Uenalan  <muenalan@cpan.org>') : ()),
);
