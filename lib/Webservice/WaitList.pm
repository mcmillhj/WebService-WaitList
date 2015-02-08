package Webservice::WaitList;
use Moo;

use namespace::clean;
use Types::Standard qw(Int);
use WWW::Google::Places;

my $GOOGLE_API_KEY = $ENV{GOOGLE_API_KEY};

has 'search_radius' => (
   is      => 'rw',
   isa     => Int,
   default => 1609,
);

has 'places_service' => (
   is      => 'ro',
   default => sub {
      return WWW::Google::Places->new( api_key => $GOOGLE_API_KEY );
   },
);

sub restaurants_near_me {
   my ($self, $location) = @_;

   my @search_results = $self->places_service->search( 
      { location => $location, 
        types    => 'bar|restaurant', 
        radius   => $self->search_radius,
      }
   );
   return unless @search_results;
   
   return map { 
      join ',', $_->name(), $_->vicinity(), $_->place_id()
   } @search_results;
}

1;

__END__

=head1 NAME 

WaitList 

=head1 DESCRIPTION

Core module for WaitList project, contains all service operations

=head1 ATTRIBUTES

=over 4

=item C<search_radius> 

search radius of Google Places API search. Accepts values in Miles (American) 
and converts them internally to Meters (used by Google Places API)

=item C<places_service>

Interface to the Google Places API

=back 

=head1 METHODS 

=over 4

=item C<restaurants_near_me>

Given a location as a hashref of lat/long coordinates, use the Google Places API
to return a listing of nearby restaurants

=back 


