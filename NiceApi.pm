package Class::NiceApi;

use 5.006;
use strict;
use warnings;

our $VERSION = '0.01.02';

our $DEBUG = 0;

use Class::Maker;

use Class::Proxy;

use IO::Extended qw(:all);

	# ThisRoutine to this_routine

	# ThisRoutine to this_routine

	# THISRoutTINE to thisroutine

our $callbacks =
{
	to_lc => sub
	{
		use Data::Dumper;

		#print Dumper \@_;

		my ( $this, $e, $m ) = @_;

		printfln "method '%s' event", ${ $m } if $DEBUG;

		${ $m } = lc ${ $m };
	},

	with_underscore => sub
	{
		my ( $this, $e, $m ) = @_;

		printfln "method '%s' event", ${ $m } if $DEBUG;

		${ $m } =~ s/([a-z])([A-Z])/$1_$2/;

		${ $m } = lc ${ $m };
	},

	custom => sub
	{
			my ( $this, $e, $m, $victim, $args ) = @_;

				# table contains special translations

			my $table = $this->table;

			if( exists $table->{${$m}} )
			{
				${$m} = $table->{${$m}};
			}
			else
			{
					# here we translate bla to Bla and bla_bla to BlaBla

				if( my @parts = split /_/, ${$m} )
				{
					${$m} = join '', map { my @chars = split //, $_; $chars[0] = uc $chars[0]; join( '',@chars ) } @parts;
				}
				else
				{
					my @chars = split //, ${$m};

					$chars[0] = uc $chars[0];

					${$m} = join( '',@chars );
				}
			}
	},
};

package Class::NiceApi;

Class::Maker::class
{
	isa => [qw( Class::Proxy )],

	public =>
	{
		hash => [qw( table )],
	},

	private =>
	{
		string => [qw( style )],
	},

	default =>
	{
		events =>
		{
			method => $callbacks->{to_lc},
		},
	},
};

sub style : method
{
	my $this = shift;

	my $key = shift;

		die "unknown style '$key' requested" unless exists $callbacks->{$key};

		$this->_style = $key;

		$this->events->{method} = $callbacks->{$key};
}

1;
__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

Class::NiceApi - translates your methodNames to my method_names

=head1 SYNOPSIS

  use Class::NiceApi;

  my $acl = Class::NiceApi->new( victim => Decision::ACL->new(), style => 'custom', table => { run_acl => 'RunACL' } );

=head1 DESCRIPTION

Perl method names should be written lowercased and multiple words should be connected via '_'. This C<is_good_coding_convention>.
Unfortunately this C<recommendation> is ignored by many CPAN authors. Class::NiceApi helps pernickety programmers as me. It translates method
names from C<isThisPerl> to C<is_this_perl> back and forth. Well, it so flexible it can translate allmost anything to anything. So it would
translate C<perl_method_name> to java programmers favorite C<perlMethodName>.

=head1 METHODS

new()

Takes following parameters (which are also available as methods).

=over 4

=item victim

An instance of a class where the method names subjected to translation.

=item style

A style is just a shortcut for the translation table. Following styles are currently supported: C<custom>, C<with_underscore> and C<to_lc>.

[Note] They are implemented via a 'translating' callback in C<$Class::NiceApi::callbacks>. It filters the source method name and returns
the destination name.

=item table

Here you can list explicit translations of method names, which are exceptions to the C<custom> style filter.

=back

=head1 NOTE

C<new> returns an instance of C<Class::NiceApi> and not the victim class. But it is a proxy class which quite well
mimics its victim (see L<Class::Proxy> and note the hiding limits).

=head1 EXPORT

None by default.

=head1 AUTHOR

Murat Uenalan, E<lt>muenalan@cpan.orgE<gt>

=head1 SEE ALSO

L<Class::Proxy>, L<Class::Protected>.

=cut
