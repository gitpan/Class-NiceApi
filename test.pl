# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 1 };
use Class::NiceApi;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

	use IO::Extended qw(:all);
	
	use Class::Maker::Examples::Human;

sub Human::do_something {}
				
		# Example 'Werewolf" were the object is good at daylist, but bad (does Acme:: things) at moonlight.
			
	my $u = new User( firstname => 'Murat', lastname => 'Uenalan' );
	
	my $user = Class::NiceApi->new( victim => $u, style => 'to_lc' );
	
	use Data::Dumper;
	
	print Dumper $user;
	
		# now we call Email and its translated in backend to email
		
	$user->Email( 'murat.uenalan@gmx.de' );

	$user->Firstname( 'Murat' );

	$user->LastName( 'Murat' );
