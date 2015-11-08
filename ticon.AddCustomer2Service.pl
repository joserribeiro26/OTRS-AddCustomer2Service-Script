#!/usr/bin/perl
#
use strict;
use warnings;

use File::Basename;
use FindBin qw($RealBin);
use lib dirname($RealBin);
use lib dirname($RealBin) . '/Kernel/cpan-lib';
use lib dirname($RealBin) . '/Custom';

use Getopt::Std;

use Kernel::System::ObjectManager;

# create object manager
local $Kernel::OM = Kernel::System::ObjectManager->new(
'Kernel::System::Log' => {
LogPrefix => 'OTRS-otrs.AddCustomer2Service',
},
);

my $ServiceObject = $Kernel::OM->Get('Kernel::System::Service');

# get options
my %Opts;
getopt( 'su', \%Opts );

if ( $Opts{h} || !$Opts{u} || !$Opts{s} ) {
print "otrs.AddCustomer2Service.pl – add customer to a service\n";
print "Copyright (C) 2012 - 2015 TI Consultores, http://ti-con.com/\n";
print "usage: otrs.AddCustomer2Service.pl -u customerlogin -s servicename \n";
exit 1;
}

my %Param = (
UserID => '1',
Active => '1',
ServiceID => '',
CustomerUserLogin => $Opts{u},
Service => $Opts{s},
);

$Param{ServiceID} = $ServiceObject->ServiceLookup(
Name => $Param{Service},
);

$ServiceObject->CustomerUserServiceMemberAdd(%Param);

print "ID Service: $Param{ServiceID}/ Service: $Param{Service} \n";
print "Customer: $Param{CustomerUserLogin}\n";

exit 0;

