package Text::ANSITable::StyleSet::SHARYANTO::PerlReleaseTypes;

# for use in my list-perl-releases script

use 5.010001;
use Moo;
use namespace::clean;

use List::MoreUtils ();

has cpan_bgcolor    => (is => 'rw');
has cpan_bgcolor    => (is => 'rw');
has noncpan_fgcolor => (is => 'rw');
has noncpan_fgcolor => (is => 'rw', default=>sub { '003300' });

# VERSION
# DATE

sub summary {
    "Set foreground and/or background color for different Perl releases";
}

sub apply {
    my ($self, $table) = @_;

    $table->add_cond_row_style(
        sub {
            my ($t, %args) = @_;
            my %styles;

            my $r = $args{row_data};
            my $cols = $t->columns;

            my $repo_idx  = List::MoreUtils::firstidx(
                sub {$_ eq 'repo'}, @$cols);

            if ($repo_idx >= 0 && $r->[$repo_idx] eq 'cpan') {
                $styles{bgcolor} = $self->cpan_bgcolor
                    if defined $self->cpan_bgcolor;
                $styles{fgcolor}=$self->cpan_fgcolor
                    if defined $self->cpan_fgcolor;
            } elsif ($repo_idx >= 0 && $r->[$repo_idx] ne 'cpan') {
                $styles{bgcolor} = $self->noncpan_bgcolor
                    if defined $self->noncpan_bgcolor;
                $styles{fgcolor} = $self->noncpan_fgcolor
                    if defined $self->noncpan_fgcolor;
            }
            \%styles;
        },
    );
}

1;

=for Pod::Coverage ^(summary|apply)$

=head1 ATTRIBUTES

=head2 cpan_bgcolor

=head2 cpan_fgcolor

=head2 noncpan_bgcolor

=head2 noncpan_fgcolor
