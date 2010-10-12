package BaconBird::KeyMap;
use Moose;

use Data::Dumper;

use constant KEY_QUIT => 0;
use constant KEY_SEND => 1;
use constant KEY_RETWEET => 2;
use constant KEY_REPLY => 3;
use constant KEY_PUBLICREPLY => 4;
use constant KEY_SHORTEN => 5;
use constant KEY_HOME_TIMELINE => 6;
use constant KEY_MENTIONS => 7;
use constant KEY_DIRECT_MESSAGES => 8;
use constant KEY_SEARCH_RESULTS => 9;
use constant KEY_USER_TIMELINE => 10;
use constant KEY_SEARCH => 11;
use constant KEY_SHOW_USER => 12;
use constant KEY_TOGGLE_FAVORITE => 13;
use constant KEY_CANCEL => 14;
use constant KEY_ENTER => 15;
use constant KEY_HELP => 16;

has 'keymap' => (
	is => 'rw',
	isa => 'HashRef',
);

sub BUILD {
	my $self = shift;
	$self->keymap({
		BaconBird::KeyMap::KEY_QUIT => { key => "q", desc => "Quit baconbird" },
		BaconBird::KeyMap::KEY_SEND => { key => "ENTER", desc => "Send new tweet or direct message" },
		BaconBird::KeyMap::KEY_RETWEET => { key => "^R", desc => "Retweet currently selected tweet" },
		BaconBird::KeyMap::KEY_REPLY => { key => "r", desc => "Reply to currently selected tweet" },
		BaconBird::KeyMap::KEY_PUBLICREPLY => { key => "R", desc => "Publicly reply to currently selected tweet" },
		BaconBird::KeyMap::KEY_SHORTEN => { key => "^O", desc => "Shorten all URLs in the current input field" },
		BaconBird::KeyMap::KEY_HOME_TIMELINE => { key => "1", desc => "Go to home timeline" },
		BaconBird::KeyMap::KEY_MENTIONS => { key => "2", desc => "Go to mentions" },
		BaconBird::KeyMap::KEY_DIRECT_MESSAGES => { key => "3", desc => "Go to direct messages" },
		BaconBird::KeyMap::KEY_SEARCH_RESULTS => { key => "4", desc => "Go to search results (if search function was used before)" },
		BaconBird::KeyMap::KEY_USER_TIMELINE => { key => "5", desc => "Go to user timeline (if show user function was used before)" },
		BaconBird::KeyMap::KEY_SEARCH => { key => "/", desc => "Start new search" },
		BaconBird::KeyMap::KEY_SHOW_USER => { key => "u", desc => "Show timeline of currently selected tweet's author" },
		BaconBird::KeyMap::KEY_TOGGLE_FAVORITE => { key => "F", desc => "Toggle favorite flag of currently selected tweet" },
		BaconBird::KeyMap::KEY_CANCEL => { key => "ESC", internal => 1 },
		BaconBird::KeyMap::KEY_ENTER => { key => "ENTER", internal => 1 },
		BaconBird::KeyMap::KEY_HELP => { key => '?', desc => "Show help" },
	});
}

sub key {
	my $self = shift;
	my ($op) = @_;
	return $self->keymap->{$op}->{key};
}

sub unbind_key {
	my $self = shift;
	my ($op) = @_;
	$self->keymap->{$op}->{key} = undef;
}

sub bind_key {
	my $self = shift;
	my ($op, $key) = @_;
	$self->keymap->{$op}->{key} = $key;
}

sub get_help_desc {
	my $self = shift;
	my @descs;

	foreach my $v (values %{$self->keymap}) {
		push(@descs, $v) unless $v->{internal};
	}
	@descs = sort { $a->{key} cmp $b->{key} } @descs;
	return \@descs;
}

no Moose;
1;