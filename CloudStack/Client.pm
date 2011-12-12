
#!/usr/bin/perl

use strict;
use warnings;
use CloudStack::BaseClient;

package CloudStack::Client;

our @ISA = qw(CloudStack::BaseClient);

sub new {
    my ($class) = shift;
    my ($args) = @_;

    my $self = CloudStack::BaseClient->new($args);

    bless $self, $class;

    return $self;
}
    
# Creates and automatically starts a virtual machine based on a service offering,
# disk offering, and template.
#
# @param array $args An associative array. The following are options for keys:
#     serviceofferingid - the ID of the service offering for the virtual machine
#     templateid - the ID of the template for the virtual machine
#     zoneid - availability zone for the virtual machine
#     account - an optional account for the virtual machine. Must be used with
#        domainId.
#     diskofferingid - the ID of the disk offering for the virtual machine. If the
#        template is of ISO format, the diskOfferingId is for the root disk volume.
#        Otherwise this parameter is used to indicate the offering for the data disk
#        volume. If the templateId parameter passed is from a Template object, the
#        diskOfferingId refers to a DATA Disk Volume created. If the templateId parameter
#        passed is from an ISO object, the diskOfferingId refers to a ROOT Disk Volume
#        created.
#     displayname - an optional user generated name for the virtual machine
#     domainid - an optional domainId for the virtual machine. If the account
#        parameter is used, domainId must also be used.
#     group - an optional group for the virtual machine
#     hostid - destination Host ID to deploy the VM to - parameter available for
#        root admin only
#     hypervisor - the hypervisor on which to deploy the virtual machine
#     ipaddress - the ip address for default vm's network
#     iptonetworklist - ip to network mapping. Can't be specified with networkIds
#        parameter. Example:
#        iptonetworklist[0].ip=10.10.10.11&iptonetworklist[0].networkid=204 - requests to
#        use ip 10.10.10.11 in network id=204
#     keyboard - an optional keyboard device type for the virtual machine. valid
#        value can be one of de,de-ch,es,fi,fr,fr-be,fr-ch,is,it,jp,nl-be,no,pt,uk,us
#     keypair - name of the ssh key pair used to login to the virtual machine
#     name - host name for the virtual machine
#     networkids - list of network ids used by virtual machine. Can't be specified
#        with ipToNetworkList parameter
#     securitygroupids - comma separated list of security groups id that going to
#        be applied to the virtual machine. Should be passed only when vm is created from
#        a zone with Basic Network support. Mutually exclusive with securitygroupnames
#        parameter
#     securitygroupnames - comma separated list of security groups names that
#        going to be applied to the virtual machine. Should be passed only when vm is
#        created from a zone with Basic Network support. Mutually exclusive with
#        securitygroupids parameter
#     size - the arbitrary size for the DATADISK volume. Mutually exclusive with
#        diskOfferingId
#     userdata - an optional binary data that can be sent to the virtual machine
#        upon a successful deployment. This binary data must be base64 encoded before
#        adding it to the request. Currently only HTTP GET is supported. Using HTTP GET
#        (via querystring), you can send up to 2KB of data after base64 encoding.
#
sub deployVirtualMachine {
    my ($self, $args) = @_;
    die("Missing required argument 'serviceofferingid'") if(!defined($args->{'serviceofferingid'}));
    die("Missing required argument 'templateid'") if(!defined($args->{'templateid'}));
    die("Missing required argument 'zoneid'") if(!defined($args->{'zoneid'}));

    return $self->request('deployVirtualMachine', $args);
}

# Destroys a virtual machine. Once destroyed, only the administrator can recover
# it.
#
# @param array $args An associative array. The following are options for keys:
#     id - The ID of the virtual machine
#
sub destroyVirtualMachine {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('destroyVirtualMachine', $args);
}

# Reboots a virtual machine.
#
# @param array $args An associative array. The following are options for keys:
#     id - The ID of the virtual machine
#
sub rebootVirtualMachine {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('rebootVirtualMachine', $args);
}

# Starts a virtual machine.
#
# @param array $args An associative array. The following are options for keys:
#     id - The ID of the virtual machine
#
sub startVirtualMachine {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('startVirtualMachine', $args);
}

# Stops a virtual machine.
#
# @param array $args An associative array. The following are options for keys:
#     id - The ID of the virtual machine
#     forced - Force stop the VM.  The caller knows the VM is stopped.
#
sub stopVirtualMachine {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('stopVirtualMachine', $args);
}

# Resets the password for virtual machine. The virtual machine must be in a
# "Stopped" state and the template must already support this feature for this
# command to take effect. [async]
#
# @param array $args An associative array. The following are options for keys:
#     id - The ID of the virtual machine
#
sub resetPasswordForVirtualMachine {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('resetPasswordForVirtualMachine', $args);
}

# Changes the service offering for a virtual machine. The virtual machine must be
# in a "Stopped" state for this command to take effect.
#
# @param array $args An associative array. The following are options for keys:
#     id - The ID of the virtual machine
#     serviceofferingid - the service offering ID to apply to the virtual machine
#
sub changeServiceForVirtualMachine {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));
    die("Missing required argument 'serviceofferingid'") if(!defined($args->{'serviceofferingid'}));

    return $self->request('changeServiceForVirtualMachine', $args);
}

# Updates parameters of a virtual machine.
#
# @param array $args An associative array. The following are options for keys:
#     id - The ID of the virtual machine
#     displayname - user generated name
#     group - group of the virtual machine
#     haenable - true if high-availability is enabled for the virtual machine,
#        false otherwise
#     ostypeid - the ID of the OS type that best represents this VM.
#     userdata - an optional binary data that can be sent to the virtual machine
#        upon a successful deployment. This binary data must be base64 encoded before
#        adding it to the request. Currently only HTTP GET is supported. Using HTTP GET
#        (via querystring), you can send up to 2KB of data after base64 encoding.
#
sub updateVirtualMachine {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('updateVirtualMachine', $args);
}

# Recovers a virtual machine.
#
# @param array $args An associative array. The following are options for keys:
#     id - The ID of the virtual machine
#
sub recoverVirtualMachine {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('recoverVirtualMachine', $args);
}

# List the virtual machines owned by the account.
#
# @param array $args An associative array. The following are options for keys:
#     account - account. Must be used with the domainId parameter.
#     domainid - the domain ID. If used with the account parameter, lists virtual
#        machines for the specified account in this domain.
#     forvirtualnetwork - list by network type; true if need to list vms using
#        Virtual Network, false otherwise
#     groupid - the group ID
#     hostid - the host ID
#     hypervisor - the target hypervisor for the template
#     id - the ID of the virtual machine
#     isrecursive - Must be used with domainId parameter. Defaults to false, but
#        if true, lists all vms from the parent specified by the domain id till leaves.
#     keyword - List by keyword
#     name - name of the virtual machine
#     networkid - list by network id
#     page - 
#     pagesize - 
#     podid - the pod ID
#     state - state of the virtual machine
#     storageid - the storage ID where vm's volumes belong to
#     zoneid - the availability zone ID
#     page - Pagination
#
sub listVirtualMachines {
    my ($self, $args) = @_;

    return $self->request('listVirtualMachines', $args);
}

# Returns an encrypted password for the VM
#
# @param array $args An associative array. The following are options for keys:
#     id - The ID of the virtual machine
#
sub getVMPassword {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('getVMPassword', $args);
}

# Attempts Migration of a virtual machine to the host specified.
#
# @param array $args An associative array. The following are options for keys:
#     hostid - destination Host ID to migrate VM to
#     virtualmachineid - the ID of the virtual machine
#
sub migrateVirtualMachine {
    my ($self, $args) = @_;
    die("Missing required argument 'hostid'") if(!defined($args->{'hostid'}));
    die("Missing required argument 'virtualmachineid'") if(!defined($args->{'virtualmachineid'}));

    return $self->request('migrateVirtualMachine', $args);
}

# Creates a template of a virtual machine. The virtual machine must be in a
# STOPPED state. A template created from this command is automatically designated
# as a private template visible to the account that created it.
#
# @param array $args An associative array. The following are options for keys:
#     displaytext - the display text of the template. This is usually used for
#        display purposes.
#     name - the name of the template
#     ostypeid - the ID of the OS Type that best represents the OS of this
#        template.
#     bits - 32 or 64 bit
#     isfeatured - true if this template is a featured template, false otherwise
#     ispublic - true if this template is a public template, false otherwise
#     passwordenabled - true if the template supports the password reset feature;
#        default is false
#     requireshvm - true if the template requres HVM, false otherwise
#     snapshotid - the ID of the snapshot the template is being created from.
#        Either this parameter, or volumeId has to be passed in
#     templatetag - the tag for this template.
#     url - Optional, only for baremetal hypervisor. The directory name where
#        template stored on CIFS server
#     virtualmachineid - Optional, VM ID. If this presents, it is going to create
#        a baremetal template for VM this ID refers to. This is only for VM whose
#        hypervisor type is BareMetal
#     volumeid - the ID of the disk volume the template is being created from.
#        Either this parameter, or snapshotId has to be passed in
#
sub createTemplate {
    my ($self, $args) = @_;
    die("Missing required argument 'displaytext'") if(!defined($args->{'displaytext'}));
    die("Missing required argument 'name'") if(!defined($args->{'name'}));
    die("Missing required argument 'ostypeid'") if(!defined($args->{'ostypeid'}));

    return $self->request('createTemplate', $args);
}

# Registers an existing template into the Cloud.com cloud.
#
# @param array $args An associative array. The following are options for keys:
#     displaytext - the display text of the template. This is usually used for
#        display purposes.
#     format - the format for the template. Possible values include QCOW2, RAW,
#        and VHD.
#     hypervisor - the target hypervisor for the template
#     name - the name of the template
#     ostypeid - the ID of the OS Type that best represents the OS of this
#        template.
#     url - the URL of where the template is hosted. Possible URL include http://
#        and https://
#     zoneid - the ID of the zone the template is to be hosted on
#     account - an optional accountName. Must be used with domainId.
#     bits - 32 or 64 bits support. 64 by default
#     checksum - the MD5 checksum value of this template
#     domainid - an optional domainId. If the account parameter is used, domainId
#        must also be used.
#     isextractable - true if the template or its derivatives are extractable;
#        default is false
#     isfeatured - true if this template is a featured template, false otherwise
#     ispublic - true if the template is available to all accounts; default is
#        true
#     passwordenabled - true if the template supports the password reset feature;
#        default is false
#     requireshvm - true if this template requires HVM
#     templatetag - the tag for this template.
#
sub registerTemplate {
    my ($self, $args) = @_;
    die("Missing required argument 'displaytext'") if(!defined($args->{'displaytext'}));
    die("Missing required argument 'format'") if(!defined($args->{'format'}));
    die("Missing required argument 'hypervisor'") if(!defined($args->{'hypervisor'}));
    die("Missing required argument 'name'") if(!defined($args->{'name'}));
    die("Missing required argument 'ostypeid'") if(!defined($args->{'ostypeid'}));
    die("Missing required argument 'url'") if(!defined($args->{'url'}));
    die("Missing required argument 'zoneid'") if(!defined($args->{'zoneid'}));

    return $self->request('registerTemplate', $args);
}

# Updates attributes of a template.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the image file
#     bootable - true if image is bootable, false otherwise
#     displaytext - the display text of the image
#     format - the format for the image
#     name - the name of the image file
#     ostypeid - the ID of the OS type that best represents the OS of this image.
#     passwordenabled - true if the image supports the password reset feature;
#        default is false
#
sub updateTemplate {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('updateTemplate', $args);
}

# Copies a template from one zone to another.
#
# @param array $args An associative array. The following are options for keys:
#     id - Template ID.
#     destzoneid - ID of the zone the template is being copied to.
#     sourcezoneid - ID of the zone the template is currently hosted on.
#
sub copyTemplate {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));
    die("Missing required argument 'destzoneid'") if(!defined($args->{'destzoneid'}));
    die("Missing required argument 'sourcezoneid'") if(!defined($args->{'sourcezoneid'}));

    return $self->request('copyTemplate', $args);
}

# Deletes a template from the system. All virtual machines using the deleted
# template will not be affected.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the template
#     zoneid - the ID of zone of the template
#
sub deleteTemplate {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteTemplate', $args);
}

# List all public, private, and privileged templates.
#
# @param array $args An associative array. The following are options for keys:
#     templatefilter - possible values are "featured", "self", "self-executable",
#        "executable", and "community".* featured-templates that are featured and are
#        public* self-templates that have been registered/created by the owner*
#        selfexecutable-templates that have been registered/created by the owner that can
#        be used to deploy a new VM* executable-all templates that can be used to deploy
#        a new VM* community-templates that are public.
#     account - list template by account. Must be used with the domainId
#        parameter.
#     domainid - list all templates in specified domain. If used with the account
#        parameter, lists all templates for an account in the specified domain.
#     hypervisor - the hypervisor for which to restrict the search
#     id - the template ID
#     keyword - List by keyword
#     name - the template name
#     page - 
#     pagesize - 
#     zoneid - list templates by zoneId
#     page - Pagination
#
sub listTemplates {
    my ($self, $args) = @_;
    die("Missing required argument 'templatefilter'") if(!defined($args->{'templatefilter'}));

    return $self->request('listTemplates', $args);
}

# Updates a template visibility permissions. A public template is visible to all
# accounts within the same domain. A private template is visible only to the owner
# of the template. A priviledged template is a private template with account
# permissions added. Only accounts specified under the template permissions are
# visible to them.
#
# @param array $args An associative array. The following are options for keys:
#     id - the template ID
#     accounts - a comma delimited list of accounts. If specified, "op" parameter
#        has to be passed in.
#     isextractable - true if the template/iso is extractable, false other wise.
#        Can be set only by root admin
#     isfeatured - true for featured template/iso, false otherwise
#     ispublic - true for public template/iso, false for private templates/isos
#     op - permission operator (add, remove, reset)
#
sub updateTemplatePermissions {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('updateTemplatePermissions', $args);
}

# List template visibility and all accounts that have permissions to view this
# template.
#
# @param array $args An associative array. The following are options for keys:
#     id - the template ID
#     account - List template visibility and permissions for the specified
#        account. Must be used with the domainId parameter.
#     domainid - List template visibility and permissions by domain. If used with
#        the account parameter, specifies in which domain the specified account exists.
#     page - Pagination
#
sub listTemplatePermissions {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('listTemplatePermissions', $args);
}

# Extracts a template
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the template
#     mode - the mode of extraction - HTTP_DOWNLOAD or FTP_UPLOAD
#     zoneid - the ID of the zone where the ISO is originally located
#     url - the url to which the ISO would be extracted
#
sub extractTemplate {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));
    die("Missing required argument 'mode'") if(!defined($args->{'mode'}));
    die("Missing required argument 'zoneid'") if(!defined($args->{'zoneid'}));

    return $self->request('extractTemplate', $args);
}

# load template into primary storage
#
# @param array $args An associative array. The following are options for keys:
#     templateid - template ID of the template to be prepared in primary
#        storage(s).
#     zoneid - zone ID of the template to be prepared in primary storage(s).
#
sub prepareTemplate {
    my ($self, $args) = @_;
    die("Missing required argument 'templateid'") if(!defined($args->{'templateid'}));
    die("Missing required argument 'zoneid'") if(!defined($args->{'zoneid'}));

    return $self->request('prepareTemplate', $args);
}

# Attaches an ISO to a virtual machine.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the ISO file
#     virtualmachineid - the ID of the virtual machine
#
sub attachIso {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));
    die("Missing required argument 'virtualmachineid'") if(!defined($args->{'virtualmachineid'}));

    return $self->request('attachIso', $args);
}

# Detaches any ISO file (if any) currently attached to a virtual machine.
#
# @param array $args An associative array. The following are options for keys:
#     virtualmachineid - The ID of the virtual machine
#
sub detachIso {
    my ($self, $args) = @_;
    die("Missing required argument 'virtualmachineid'") if(!defined($args->{'virtualmachineid'}));

    return $self->request('detachIso', $args);
}

# Lists all available ISO files.
#
# @param array $args An associative array. The following are options for keys:
#     account - the account of the ISO file. Must be used with the domainId
#        parameter.
#     bootable - true if the ISO is bootable, false otherwise
#     domainid - lists all available ISO files by ID of a domain. If used with the
#        account parameter, lists all available ISO files for the account in the ID of a
#        domain.
#     hypervisor - the hypervisor for which to restrict the search
#     id - list all isos by id
#     isofilter - possible values are "featured", "self",
#        "self-executable","executable", and "community". * featured-ISOs that are
#        featured and are publicself-ISOs that have been registered/created by the owner.
#        * selfexecutable-ISOs that have been registered/created by the owner that can be
#        used to deploy a new VM. * executable-all ISOs that can be used to deploy a new
#        VM * community-ISOs that are public.
#     ispublic - true if the ISO is publicly available to all users, false
#        otherwise.
#     isready - true if this ISO is ready to be deployed
#     keyword - List by keyword
#     name - list all isos by name
#     page - 
#     pagesize - 
#     zoneid - the ID of the zone
#     page - Pagination
#
sub listIsos {
    my ($self, $args) = @_;

    return $self->request('listIsos', $args);
}

# Registers an existing ISO into the Cloud.com Cloud.
#
# @param array $args An associative array. The following are options for keys:
#     displaytext - the display text of the ISO. This is usually used for display
#        purposes.
#     name - the name of the ISO
#     url - the URL to where the ISO is currently being hosted
#     zoneid - the ID of the zone you wish to register the ISO to.
#     account - an optional account name. Must be used with domainId.
#     bootable - true if this ISO is bootable
#     domainid - an optional domainId. If the account parameter is used, domainId
#        must also be used.
#     isextractable - true if the iso or its derivatives are extractable; default
#        is false
#     isfeatured - true if you want this ISO to be featured
#     ispublic - true if you want to register the ISO to be publicly available to
#        all users, false otherwise.
#     ostypeid - the ID of the OS Type that best represents the OS of this ISO
#
sub registerIso {
    my ($self, $args) = @_;
    die("Missing required argument 'displaytext'") if(!defined($args->{'displaytext'}));
    die("Missing required argument 'name'") if(!defined($args->{'name'}));
    die("Missing required argument 'url'") if(!defined($args->{'url'}));
    die("Missing required argument 'zoneid'") if(!defined($args->{'zoneid'}));

    return $self->request('registerIso', $args);
}

# Updates an ISO file.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the image file
#     bootable - true if image is bootable, false otherwise
#     displaytext - the display text of the image
#     format - the format for the image
#     name - the name of the image file
#     ostypeid - the ID of the OS type that best represents the OS of this image.
#     passwordenabled - true if the image supports the password reset feature;
#        default is false
#
sub updateIso {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('updateIso', $args);
}

# Deletes an ISO file.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the ISO file
#     zoneid - the ID of the zone of the ISO file. If not specified, the ISO will
#        be deleted from all the zones
#
sub deleteIso {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteIso', $args);
}

# Copies a template from one zone to another.
#
# @param array $args An associative array. The following are options for keys:
#     id - Template ID.
#     destzoneid - ID of the zone the template is being copied to.
#     sourcezoneid - ID of the zone the template is currently hosted on.
#
sub copyIso {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));
    die("Missing required argument 'destzoneid'") if(!defined($args->{'destzoneid'}));
    die("Missing required argument 'sourcezoneid'") if(!defined($args->{'sourcezoneid'}));

    return $self->request('copyIso', $args);
}

# Updates iso permissions
#
# @param array $args An associative array. The following are options for keys:
#     id - the template ID
#     accounts - a comma delimited list of accounts. If specified, "op" parameter
#        has to be passed in.
#     isextractable - true if the template/iso is extractable, false other wise.
#        Can be set only by root admin
#     isfeatured - true for featured template/iso, false otherwise
#     ispublic - true for public template/iso, false for private templates/isos
#     op - permission operator (add, remove, reset)
#
sub updateIsoPermissions {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('updateIsoPermissions', $args);
}

# List template visibility and all accounts that have permissions to view this
# template.
#
# @param array $args An associative array. The following are options for keys:
#     id - the template ID
#     account - List template visibility and permissions for the specified
#        account. Must be used with the domainId parameter.
#     domainid - List template visibility and permissions by domain. If used with
#        the account parameter, specifies in which domain the specified account exists.
#     page - Pagination
#
sub listIsoPermissions {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('listIsoPermissions', $args);
}

# Extracts an ISO
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the ISO file
#     mode - the mode of extraction - HTTP_DOWNLOAD or FTP_UPLOAD
#     zoneid - the ID of the zone where the ISO is originally located
#     url - the url to which the ISO would be extracted
#
sub extractIso {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));
    die("Missing required argument 'mode'") if(!defined($args->{'mode'}));
    die("Missing required argument 'zoneid'") if(!defined($args->{'zoneid'}));

    return $self->request('extractIso', $args);
}

# Attaches a disk volume to a virtual machine.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the disk volume
#     virtualmachineid - the ID of the virtual machine
#     deviceid - the ID of the device to map the volume to within the guest OS. If
#        no deviceId is passed in, the next available deviceId will be chosen. Possible
#        values for a Linux OS are:* 1 - /dev/xvdb* 2 - /dev/xvdc* 4 - /dev/xvde* 5 -
#        /dev/xvdf* 6 - /dev/xvdg* 7 - /dev/xvdh* 8 - /dev/xvdi* 9 - /dev/xvdj
#
sub attachVolume {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));
    die("Missing required argument 'virtualmachineid'") if(!defined($args->{'virtualmachineid'}));

    return $self->request('attachVolume', $args);
}

# Detaches a disk volume from a virtual machine.
#
# @param array $args An associative array. The following are options for keys:
#     deviceid - the device ID on the virtual machine where volume is detached
#        from
#     id - the ID of the disk volume
#     virtualmachineid - the ID of the virtual machine where the volume is
#        detached from
#
sub detachVolume {
    my ($self, $args) = @_;

    return $self->request('detachVolume', $args);
}

# Creates a disk volume from a disk offering. This disk volume must still be
# attached to a virtual machine to make use of it.
#
# @param array $args An associative array. The following are options for keys:
#     name - the name of the disk volume
#     account - the account associated with the disk volume. Must be used with the
#        domainId parameter.
#     diskofferingid - the ID of the disk offering. Either diskOfferingId or
#        snapshotId must be passed in.
#     domainid - the domain ID associated with the disk offering. If used with the
#        account parameter returns the disk volume associated with the account for the
#        specified domain.
#     size - Arbitrary volume size
#     snapshotid - the snapshot ID for the disk volume. Either diskOfferingId or
#        snapshotId must be passed in.
#     zoneid - the ID of the availability zone
#
sub createVolume {
    my ($self, $args) = @_;
    die("Missing required argument 'name'") if(!defined($args->{'name'}));

    return $self->request('createVolume', $args);
}

# Deletes a detached disk volume.
#
# @param array $args An associative array. The following are options for keys:
#     id - The ID of the disk volume
#
sub deleteVolume {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteVolume', $args);
}

# Lists all volumes.
#
# @param array $args An associative array. The following are options for keys:
#     account - the account associated with the disk volume. Must be used with the
#        domainId parameter.
#     domainid - Lists all disk volumes for the specified domain ID. If used with
#        the account parameter, returns all disk volumes for an account in the specified
#        domain ID.
#     hostid - list volumes on specified host
#     id - the ID of the disk volume
#     isrecursive - defaults to false, but if true, lists all volumes from the
#        parent specified by the domain id till leaves.
#     keyword - List by keyword
#     name - the name of the disk volume
#     page - 
#     pagesize - 
#     podid - the pod id the disk volume belongs to
#     type - the type of disk volume
#     virtualmachineid - the ID of the virtual machine
#     zoneid - the ID of the availability zone
#     page - Pagination
#
sub listVolumes {
    my ($self, $args) = @_;

    return $self->request('listVolumes', $args);
}

# Extracts volume
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the volume
#     mode - the mode of extraction - HTTP_DOWNLOAD or FTP_UPLOAD
#     zoneid - the ID of the zone where the volume is located
#     url - the url to which the volume would be extracted
#
sub extractVolume {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));
    die("Missing required argument 'mode'") if(!defined($args->{'mode'}));
    die("Missing required argument 'zoneid'") if(!defined($args->{'zoneid'}));

    return $self->request('extractVolume', $args);
}

# Adds a new host.
#
# @param array $args An associative array. The following are options for keys:
#     hypervisor - hypervisor type of the host
#     password - the password for the host
#     url - the host URL
#     username - the username for the host
#     zoneid - the Zone ID for the host
#     allocationstate - Allocation state of this Host for allocation of new
#        resources
#     clusterid - the cluster ID for the host
#     clustername - the cluster name for the host
#     hosttags - list of tags to be added to the host
#     podid - the Pod ID for the host
#
sub addHost {
    my ($self, $args) = @_;
    die("Missing required argument 'hypervisor'") if(!defined($args->{'hypervisor'}));
    die("Missing required argument 'password'") if(!defined($args->{'password'}));
    die("Missing required argument 'url'") if(!defined($args->{'url'}));
    die("Missing required argument 'username'") if(!defined($args->{'username'}));
    die("Missing required argument 'zoneid'") if(!defined($args->{'zoneid'}));

    return $self->request('addHost', $args);
}

# Adds a new cluster
#
# @param array $args An associative array. The following are options for keys:
#     clustername - the cluster name
#     clustertype - type of the cluster: CloudManaged, ExternalManaged
#     hypervisor - hypervisor type of the cluster:
#        XenServer,KVM,VMware,Hyperv,BareMetal,Simulator
#     zoneid - the Zone ID for the cluster
#     allocationstate - Allocation state of this cluster for allocation of new
#        resources
#     password - the password for the host
#     podid - the Pod ID for the host
#     url - the URL
#     username - the username for the cluster
#
sub addCluster {
    my ($self, $args) = @_;
    die("Missing required argument 'clustername'") if(!defined($args->{'clustername'}));
    die("Missing required argument 'clustertype'") if(!defined($args->{'clustertype'}));
    die("Missing required argument 'hypervisor'") if(!defined($args->{'hypervisor'}));
    die("Missing required argument 'zoneid'") if(!defined($args->{'zoneid'}));

    return $self->request('addCluster', $args);
}

# Deletes a cluster.
#
# @param array $args An associative array. The following are options for keys:
#     id - the cluster ID
#
sub deleteCluster {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteCluster', $args);
}

# Updates an existing cluster
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the Cluster
#     allocationstate - Allocation state of this cluster for allocation of new
#        resources
#     clustername - the cluster name
#     clustertype - hypervisor type of the cluster
#     hypervisor - hypervisor type of the cluster
#     managedstate - whether this cluster is managed by cloudstack
#
sub updateCluster {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('updateCluster', $args);
}

# Reconnects a host.
#
# @param array $args An associative array. The following are options for keys:
#     id - the host ID
#
sub reconnectHost {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('reconnectHost', $args);
}

# Updates a host.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the host to update
#     allocationstate - Allocation state of this Host for allocation of new
#        resources
#     hosttags - list of tags to be added to the host
#     oscategoryid - the id of Os category to update the host with
#
sub updateHost {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('updateHost', $args);
}

# Deletes a host.
#
# @param array $args An associative array. The following are options for keys:
#     id - the host ID
#     forced - Force delete the host. All HA enabled vms running on the host will
#        be put to HA; HA disabled ones will be stopped
#     forcedestroylocalstorage - Force destroy local storage on this host. All VMs
#        created on this local storage will be destroyed
#
sub deleteHost {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteHost', $args);
}

# Prepares a host for maintenance.
#
# @param array $args An associative array. The following are options for keys:
#     id - the host ID
#
sub prepareHostForMaintenance {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('prepareHostForMaintenance', $args);
}

# Cancels host maintenance.
#
# @param array $args An associative array. The following are options for keys:
#     id - the host ID
#
sub cancelHostMaintenance {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('cancelHostMaintenance', $args);
}

# Lists hosts.
#
# @param array $args An associative array. The following are options for keys:
#     allocationstate - list hosts by allocation state
#     clusterid - lists hosts existing in particular cluster
#     id - the id of the host
#     keyword - List by keyword
#     name - the name of the host
#     page - 
#     pagesize - 
#     podid - the Pod ID for the host
#     state - the state of the host
#     type - the host type
#     virtualmachineid - lists hosts in the same cluster as this VM and flag hosts
#        with enough CPU/RAm to host this VM
#     zoneid - the Zone ID for the host
#     page - Pagination
#
sub listHosts {
    my ($self, $args) = @_;

    return $self->request('listHosts', $args);
}

# Adds secondary storage.
#
# @param array $args An associative array. The following are options for keys:
#     url - the URL for the secondary storage
#     zoneid - the Zone ID for the secondary storage
#
sub addSecondaryStorage {
    my ($self, $args) = @_;
    die("Missing required argument 'url'") if(!defined($args->{'url'}));

    return $self->request('addSecondaryStorage', $args);
}

# Update password of a host/pool on management server.
#
# @param array $args An associative array. The following are options for keys:
#     password - the password for the host/cluster
#     username - the username for the host/cluster
#     clusterid - the cluster ID for the host
#     hostid - the host ID
#
sub updateHostPassword {
    my ($self, $args) = @_;
    die("Missing required argument 'password'") if(!defined($args->{'password'}));
    die("Missing required argument 'username'") if(!defined($args->{'username'}));

    return $self->request('updateHostPassword', $args);
}

# Lists clusters.
#
# @param array $args An associative array. The following are options for keys:
#     allocationstate - lists clusters by allocation state
#     clustertype - lists clusters by cluster type
#     hypervisor - lists clusters by hypervisor type
#     id - lists clusters by the cluster ID
#     keyword - List by keyword
#     managedstate - whether this cluster is managed by cloudstack
#     name - lists clusters by the cluster name
#     page - 
#     pagesize - 
#     podid - lists clusters by Pod ID
#     zoneid - lists clusters by Zone ID
#     page - Pagination
#
sub listClusters {
    my ($self, $args) = @_;

    return $self->request('listClusters', $args);
}

# Creates an account
#
# @param array $args An associative array. The following are options for keys:
#     accounttype - Type of the account.  Specify 0 for user, 1 for root admin,
#        and 2 for domain admin
#     email - email
#     firstname - firstname
#     lastname - lastname
#     password - Hashed password (Default is MD5). If you wish to use any other
#        hashing algorithm, you would need to write a custom authentication adapter See
#        Docs section.
#     username - Unique username.
#     account - Creates the user under the specified account. If no account is
#        specified, the username will be used as the account name.
#     domainid - Creates the user under the specified domain.
#     networkdomain - Network domain for the account's networks
#     timezone - Specifies a timezone for this command. For more information on
#        the timezone parameter, see Time Zone Format.
#
sub createAccount {
    my ($self, $args) = @_;
    die("Missing required argument 'accounttype'") if(!defined($args->{'accounttype'}));
    die("Missing required argument 'email'") if(!defined($args->{'email'}));
    die("Missing required argument 'firstname'") if(!defined($args->{'firstname'}));
    die("Missing required argument 'lastname'") if(!defined($args->{'lastname'}));
    die("Missing required argument 'password'") if(!defined($args->{'password'}));
    die("Missing required argument 'username'") if(!defined($args->{'username'}));

    return $self->request('createAccount', $args);
}

# Deletes a account, and all users associated with this account
#
# @param array $args An associative array. The following are options for keys:
#     id - Account id
#
sub deleteAccount {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteAccount', $args);
}

# Updates account information for the authenticated user
#
# @param array $args An associative array. The following are options for keys:
#     account - the current account name
#     domainid - the ID of the domain where the account exists
#     newname - new name for the account
#     networkdomain - Network domain for the account's networks
#
sub updateAccount {
    my ($self, $args) = @_;
    die("Missing required argument 'account'") if(!defined($args->{'account'}));
    die("Missing required argument 'domainid'") if(!defined($args->{'domainid'}));
    die("Missing required argument 'newname'") if(!defined($args->{'newname'}));

    return $self->request('updateAccount', $args);
}

# Disables an account
#
# @param array $args An associative array. The following are options for keys:
#     account - Disables specified account.
#     domainid - Disables specified account in this domain.
#     lock - If true, only lock the account; else disable the account
#
sub disableAccount {
    my ($self, $args) = @_;
    die("Missing required argument 'account'") if(!defined($args->{'account'}));
    die("Missing required argument 'domainid'") if(!defined($args->{'domainid'}));
    die("Missing required argument 'lock'") if(!defined($args->{'lock'}));

    return $self->request('disableAccount', $args);
}

# Enables an account
#
# @param array $args An associative array. The following are options for keys:
#     account - Enables specified account.
#     domainid - Enables specified account in this domain.
#
sub enableAccount {
    my ($self, $args) = @_;
    die("Missing required argument 'account'") if(!defined($args->{'account'}));
    die("Missing required argument 'domainid'") if(!defined($args->{'domainid'}));

    return $self->request('enableAccount', $args);
}

# Lists accounts and provides detailed account information for listed accounts
#
# @param array $args An associative array. The following are options for keys:
#     accounttype - list accounts by account type. Valid account types are 1
#        (admin), 2 (domain-admin), and 0 (user).
#     domainid - list all accounts in specified domain. If used with the name
#        parameter, retrieves account information for the account with specified name in
#        specified domain.
#     id - list account by account ID
#     iscleanuprequired - list accounts by cleanuprequred attribute (values are
#        true or false)
#     isrecursive - defaults to false, but if true, lists all accounts from the
#        parent specified by the domain id till leaves.
#     keyword - List by keyword
#     name - list account by account name
#     page - 
#     pagesize - 
#     state - list accounts by state. Valid states are enabled, disabled, and
#        locked.
#     page - Pagination
#
sub listAccounts {
    my ($self, $args) = @_;

    return $self->request('listAccounts', $args);
}

# Creates an instant snapshot of a volume.
#
# @param array $args An associative array. The following are options for keys:
#     volumeid - The ID of the disk volume
#     account - The account of the snapshot. The account parameter must be used
#        with the domainId parameter.
#     domainid - The domain ID of the snapshot. If used with the account
#        parameter, specifies a domain for the account associated with the disk volume.
#     policyid - policy id of the snapshot, if this is null, then use
#        MANUAL_POLICY.
#
sub createSnapshot {
    my ($self, $args) = @_;
    die("Missing required argument 'volumeid'") if(!defined($args->{'volumeid'}));

    return $self->request('createSnapshot', $args);
}

# Lists all available snapshots for the account.
#
# @param array $args An associative array. The following are options for keys:
#     account - lists snapshot belongig to the specified account. Must be used
#        with the domainId parameter.
#     domainid - the domain ID. If used with the account parameter, lists
#        snapshots for the specified account in this domain.
#     id - lists snapshot by snapshot ID
#     intervaltype - valid values are HOURLY, DAILY, WEEKLY, and MONTHLY.
#     isrecursive - defaults to false, but if true, lists all snapshots from the
#        parent specified by the domain id till leaves.
#     keyword - List by keyword
#     name - lists snapshot by snapshot name
#     page - 
#     pagesize - 
#     snapshottype - valid values are MANUAL or RECURRING.
#     volumeid - the ID of the disk volume
#     page - Pagination
#
sub listSnapshots {
    my ($self, $args) = @_;

    return $self->request('listSnapshots', $args);
}

# Deletes a snapshot of a disk volume.
#
# @param array $args An associative array. The following are options for keys:
#     id - The ID of the snapshot
#
sub deleteSnapshot {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteSnapshot', $args);
}

# Creates a snapshot policy for the account.
#
# @param array $args An associative array. The following are options for keys:
#     intervaltype - valid values are HOURLY, DAILY, WEEKLY, and MONTHLY
#     maxsnaps - maximum number of snapshots to retain
#     schedule - time the snapshot is scheduled to be taken. Format is:* if
#        HOURLY, MM* if DAILY, MM:HH* if WEEKLY, MM:HH:DD (1-7)* if MONTHLY, MM:HH:DD
#        (1-28)
#     timezone - Specifies a timezone for this command. For more information on
#        the timezone parameter, see Time Zone Format.
#     volumeid - the ID of the disk volume
#
sub createSnapshotPolicy {
    my ($self, $args) = @_;
    die("Missing required argument 'intervaltype'") if(!defined($args->{'intervaltype'}));
    die("Missing required argument 'maxsnaps'") if(!defined($args->{'maxsnaps'}));
    die("Missing required argument 'schedule'") if(!defined($args->{'schedule'}));
    die("Missing required argument 'timezone'") if(!defined($args->{'timezone'}));
    die("Missing required argument 'volumeid'") if(!defined($args->{'volumeid'}));

    return $self->request('createSnapshotPolicy', $args);
}

# Deletes snapshot policies for the account.
#
# @param array $args An associative array. The following are options for keys:
#     id - the Id of the snapshot
#     ids - list of snapshots IDs separated by comma
#
sub deleteSnapshotPolicies {
    my ($self, $args) = @_;

    return $self->request('deleteSnapshotPolicies', $args);
}

# Lists snapshot policies.
#
# @param array $args An associative array. The following are options for keys:
#     volumeid - the ID of the disk volume
#     account - lists snapshot policies for the specified account. Must be used
#        with domainid parameter.
#     domainid - the domain ID. If used with the account parameter, lists snapshot
#        policies for the specified account in this domain.
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     page - Pagination
#
sub listSnapshotPolicies {
    my ($self, $args) = @_;
    die("Missing required argument 'volumeid'") if(!defined($args->{'volumeid'}));

    return $self->request('listSnapshotPolicies', $args);
}

# Creates a user for an account that already exists
#
# @param array $args An associative array. The following are options for keys:
#     account - Creates the user under the specified account. If no account is
#        specified, the username will be used as the account name.
#     email - email
#     firstname - firstname
#     lastname - lastname
#     password - Hashed password (Default is MD5). If you wish to use any other
#        hashing algorithm, you would need to write a custom authentication adapter See
#        Docs section.
#     username - Unique username.
#     domainid - Creates the user under the specified domain. Has to be
#        accompanied with the account parameter
#     timezone - Specifies a timezone for this command. For more information on
#        the timezone parameter, see Time Zone Format.
#
sub createUser {
    my ($self, $args) = @_;
    die("Missing required argument 'account'") if(!defined($args->{'account'}));
    die("Missing required argument 'email'") if(!defined($args->{'email'}));
    die("Missing required argument 'firstname'") if(!defined($args->{'firstname'}));
    die("Missing required argument 'lastname'") if(!defined($args->{'lastname'}));
    die("Missing required argument 'password'") if(!defined($args->{'password'}));
    die("Missing required argument 'username'") if(!defined($args->{'username'}));

    return $self->request('createUser', $args);
}

# Creates a user for an account
#
# @param array $args An associative array. The following are options for keys:
#     id - Deletes a user
#
sub deleteUser {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteUser', $args);
}

# Updates a user account
#
# @param array $args An associative array. The following are options for keys:
#     id - User id
#     email - email
#     firstname - first name
#     lastname - last name
#     password - Hashed password (default is MD5). If you wish to use any other
#        hasing algorithm, you would need to write a custom authentication adapter
#     timezone - Specifies a timezone for this command. For more information on
#        the timezone parameter, see Time Zone Format.
#     userapikey - The API key for the user. Must be specified with userSecretKey
#     username - Unique username
#     usersecretkey - The secret key for the user. Must be specified with
#        userApiKey
#
sub updateUser {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('updateUser', $args);
}

# Lists user accounts
#
# @param array $args An associative array. The following are options for keys:
#     account - List user by account. Must be used with the domainId parameter.
#     accounttype - List users by account type. Valid types include admin,
#        domain-admin, read-only-admin, or user.
#     domainid - List all users in a domain. If used with the account parameter,
#        lists an account in a specific domain.
#     id - List user by ID.
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     state - List users by state of the user account.
#     username - List user by the username
#     page - Pagination
#
sub listUsers {
    my ($self, $args) = @_;

    return $self->request('listUsers', $args);
}

# Disables a user account
#
# @param array $args An associative array. The following are options for keys:
#     id - Disables user by user ID.
#
sub disableUser {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('disableUser', $args);
}

# Enables a user account
#
# @param array $args An associative array. The following are options for keys:
#     id - Enables user by user ID.
#
sub enableUser {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('enableUser', $args);
}

# Creates a domain
#
# @param array $args An associative array. The following are options for keys:
#     name - creates domain with this name
#     networkdomain - Network domain for networks in the domain
#     parentdomainid - assigns new domain a parent domain by domain ID of the
#        parent.  If no parent domain is specied, the ROOT domain is assumed.
#
sub createDomain {
    my ($self, $args) = @_;
    die("Missing required argument 'name'") if(!defined($args->{'name'}));

    return $self->request('createDomain', $args);
}

# Updates a domain with a new name
#
# @param array $args An associative array. The following are options for keys:
#     id - ID of domain to update
#     name - updates domain with this name
#     networkdomain - Network domain for the domain's networks
#
sub updateDomain {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('updateDomain', $args);
}

# Deletes a specified domain
#
# @param array $args An associative array. The following are options for keys:
#     id - ID of domain to delete
#     cleanup - true if all domain resources (child domains, accounts) have to be
#        cleaned up, false otherwise
#
sub deleteDomain {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteDomain', $args);
}

# Lists domains and provides detailed information for listed domains
#
# @param array $args An associative array. The following are options for keys:
#     id - List domain by domain ID.
#     keyword - List by keyword
#     level - List domains by domain level.
#     name - List domain by domain name.
#     page - 
#     pagesize - 
#     page - Pagination
#
sub listDomains {
    my ($self, $args) = @_;

    return $self->request('listDomains', $args);
}

# Lists all children domains belonging to a specified domain
#
# @param array $args An associative array. The following are options for keys:
#     id - list children domain by parent domain ID.
#     isrecursive - to return the entire tree, use the value "true". To return the
#        first level children, use the value "false".
#     keyword - List by keyword
#     name - list children domains by name
#     page - 
#     pagesize - 
#     page - Pagination
#
sub listDomainChildren {
    my ($self, $args) = @_;

    return $self->request('listDomainChildren', $args);
}

# Lists all supported OS types for this cloud.
#
# @param array $args An associative array. The following are options for keys:
#     id - list by Os type Id
#     keyword - List by keyword
#     oscategoryid - list by Os Category id
#     page - 
#     pagesize - 
#     page - Pagination
#
sub listOsTypes {
    my ($self, $args) = @_;

    return $self->request('listOsTypes', $args);
}

# Lists all supported OS categories for this cloud.
#
# @param array $args An associative array. The following are options for keys:
#     id - list Os category by id
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     page - Pagination
#
sub listOsCategories {
    my ($self, $args) = @_;

    return $self->request('listOsCategories', $args);
}

# Creates a service offering.
#
# @param array $args An associative array. The following are options for keys:
#     cpunumber - the CPU number of the service offering
#     cpuspeed - the CPU speed of the service offering in MHz.
#     displaytext - the display text of the service offering
#     memory - the total memory of the service offering in MB
#     name - the name of the service offering
#     domainid - the ID of the containing domain, null for public offerings
#     hosttags - the host tag for this service offering.
#     issystem - is this a system vm offering
#     limitcpuuse - restrict the CPU usage to committed service offering
#     networkrate - data transfer rate in megabits per second allowed. Supported
#        only for non-System offering and system offerings having "domainrouter"
#        systemvmtype
#     offerha - the HA for the service offering
#     storagetype - the storage type of the service offering. Values are local and
#        shared.
#     systemvmtype - the system VM type. Possible types are "domainrouter",
#        "consoleproxy" and "secondarystoragevm".
#     tags - the tags for this service offering.
#
sub createServiceOffering {
    my ($self, $args) = @_;
    die("Missing required argument 'cpunumber'") if(!defined($args->{'cpunumber'}));
    die("Missing required argument 'cpuspeed'") if(!defined($args->{'cpuspeed'}));
    die("Missing required argument 'displaytext'") if(!defined($args->{'displaytext'}));
    die("Missing required argument 'memory'") if(!defined($args->{'memory'}));
    die("Missing required argument 'name'") if(!defined($args->{'name'}));

    return $self->request('createServiceOffering', $args);
}

# Deletes a service offering.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the service offering
#
sub deleteServiceOffering {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteServiceOffering', $args);
}

# Updates a service offering.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the service offering to be updated
#     displaytext - the display text of the service offering to be updated
#     name - the name of the service offering to be updated
#
sub updateServiceOffering {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('updateServiceOffering', $args);
}

# Lists all available service offerings.
#
# @param array $args An associative array. The following are options for keys:
#     domainid - the ID of the domain associated with the service offering
#     id - ID of the service offering
#     issystem - is this a system vm offering
#     keyword - List by keyword
#     name - name of the service offering
#     page - 
#     pagesize - 
#     systemvmtype - the system VM type. Possible types are "consoleproxy",
#        "secondarystoragevm" or "domainrouter".
#     virtualmachineid - the ID of the virtual machine. Pass this in if you want
#        to see the available service offering that a virtual machine can be changed to.
#     page - Pagination
#
sub listServiceOfferings {
    my ($self, $args) = @_;

    return $self->request('listServiceOfferings', $args);
}

# Creates a disk offering.
#
# @param array $args An associative array. The following are options for keys:
#     displaytext - alternate display text of the disk offering
#     name - name of the disk offering
#     customized - whether disk offering is custom or not
#     disksize - size of the disk offering in GB
#     domainid - the ID of the containing domain, null for public offerings
#     tags - tags for the disk offering
#
sub createDiskOffering {
    my ($self, $args) = @_;
    die("Missing required argument 'displaytext'") if(!defined($args->{'displaytext'}));
    die("Missing required argument 'name'") if(!defined($args->{'name'}));

    return $self->request('createDiskOffering', $args);
}

# Updates a disk offering.
#
# @param array $args An associative array. The following are options for keys:
#     id - ID of the disk offering
#     displaytext - updates alternate display text of the disk offering with this
#        value
#     name - updates name of the disk offering with this value
#
sub updateDiskOffering {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('updateDiskOffering', $args);
}

# Updates a disk offering.
#
# @param array $args An associative array. The following are options for keys:
#     id - ID of the disk offering
#
sub deleteDiskOffering {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteDiskOffering', $args);
}

# Lists all available disk offerings.
#
# @param array $args An associative array. The following are options for keys:
#     domainid - the ID of the domain of the disk offering.
#     id - ID of the disk offering
#     keyword - List by keyword
#     name - name of the disk offering
#     page - 
#     pagesize - 
#     page - Pagination
#
sub listDiskOfferings {
    my ($self, $args) = @_;

    return $self->request('listDiskOfferings', $args);
}

# Creates a VLAN IP range.
#
# @param array $args An associative array. The following are options for keys:
#     startip - the beginning IP address in the VLAN IP range
#     account - account who will own the VLAN. If VLAN is Zone wide, this
#        parameter should be ommited
#     domainid - domain ID of the account owning a VLAN
#     endip - the ending IP address in the VLAN IP range
#     forvirtualnetwork - true if VLAN is of Virtual type, false if Direct
#     gateway - the gateway of the VLAN IP range
#     netmask - the netmask of the VLAN IP range
#     networkid - the network id
#     podid - optional parameter. Have to be specified for Direct Untagged vlan
#        only.
#     vlan - the ID or VID of the VLAN. Default is an "untagged" VLAN.
#     zoneid - the Zone ID of the VLAN IP range
#
sub createVlanIpRange {
    my ($self, $args) = @_;
    die("Missing required argument 'startip'") if(!defined($args->{'startip'}));

    return $self->request('createVlanIpRange', $args);
}

# Creates a VLAN IP range.
#
# @param array $args An associative array. The following are options for keys:
#     id - the id of the VLAN IP range
#
sub deleteVlanIpRange {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteVlanIpRange', $args);
}

# Lists all VLAN IP ranges.
#
# @param array $args An associative array. The following are options for keys:
#     account - the account with which the VLAN IP range is associated. Must be
#        used with the domainId parameter.
#     domainid - the domain ID with which the VLAN IP range is associated.  If
#        used with the account parameter, returns all VLAN IP ranges for that account in
#        the specified domain.
#     forvirtualnetwork - true if VLAN is of Virtual type, false if Direct
#     id - the ID of the VLAN IP range
#     keyword - List by keyword
#     networkid - network id of the VLAN IP range
#     page - 
#     pagesize - 
#     podid - the Pod ID of the VLAN IP range
#     vlan - the ID or VID of the VLAN. Default is an "untagged" VLAN.
#     zoneid - the Zone ID of the VLAN IP range
#     page - Pagination
#
sub listVlanIpRanges {
    my ($self, $args) = @_;

    return $self->request('listVlanIpRanges', $args);
}

# Acquires and associates a public IP to an account.
#
# @param array $args An associative array. The following are options for keys:
#     zoneid - the ID of the availability zone you want to acquire an public IP
#        address from
#     account - the account to associate with this IP address
#     domainid - the ID of the domain to associate with this IP address
#     networkid - The network this ip address should be associated to.
#
sub associateIpAddress {
    my ($self, $args) = @_;
    die("Missing required argument 'zoneid'") if(!defined($args->{'zoneid'}));

    return $self->request('associateIpAddress', $args);
}

# Disassociates an ip address from the account.
#
# @param array $args An associative array. The following are options for keys:
#     id - the id of the public ip address to disassociate
#
sub disassociateIpAddress {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('disassociateIpAddress', $args);
}

# Lists all public ip addresses
#
# @param array $args An associative array. The following are options for keys:
#     account - lists all public IP addresses by account. Must be used with the
#        domainId parameter.
#     allocatedonly - limits search results to allocated public IP addresses
#     domainid - lists all public IP addresses by domain ID. If used with the
#        account parameter, lists all public IP addresses by account for specified
#        domain.
#     forloadbalancing - list only ips used for load balancing
#     forvirtualnetwork - the virtual network for the IP address
#     id - lists ip address by id
#     ipaddress - lists the specified IP address
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     vlanid - lists all public IP addresses by VLAN ID
#     zoneid - lists all public IP addresses by Zone ID
#     page - Pagination
#
sub listPublicIpAddresses {
    my ($self, $args) = @_;

    return $self->request('listPublicIpAddresses', $args);
}

# Lists all port forwarding rules for an IP address.
#
# @param array $args An associative array. The following are options for keys:
#     account - account. Must be used with the domainId parameter.
#     domainid - the domain ID. If used with the account parameter, lists port
#        forwarding rules for the specified account in this domain.
#     id - Lists rule with the specified ID.
#     ipaddressid - the id of IP address of the port forwarding services
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     page - Pagination
#
sub listPortForwardingRules {
    my ($self, $args) = @_;

    return $self->request('listPortForwardingRules', $args);
}

# Creates a port forwarding rule
#
# @param array $args An associative array. The following are options for keys:
#     ipaddressid - the IP address id of the port forwarding rule
#     privateport - the starting port of port forwarding rule's private port
#        range
#     protocol - the protocol for the port fowarding rule. Valid values are TCP or
#        UDP.
#     publicport - the starting port of port forwarding rule's public port range
#     virtualmachineid - the ID of the virtual machine for the port forwarding
#        rule
#     cidrlist - the cidr list to forward traffic from
#     openfirewall - if true, firewall rule for source/end pubic port is
#        automatically created; if false - firewall rule has to be created explicitely.
#        Has value true by default
#     privateendport - the ending port of port forwarding rule's private port
#        range
#     publicendport - the ending port of port forwarding rule's private port
#        range
#
sub createPortForwardingRule {
    my ($self, $args) = @_;
    die("Missing required argument 'ipaddressid'") if(!defined($args->{'ipaddressid'}));
    die("Missing required argument 'privateport'") if(!defined($args->{'privateport'}));
    die("Missing required argument 'protocol'") if(!defined($args->{'protocol'}));
    die("Missing required argument 'publicport'") if(!defined($args->{'publicport'}));
    die("Missing required argument 'virtualmachineid'") if(!defined($args->{'virtualmachineid'}));

    return $self->request('createPortForwardingRule', $args);
}

# Deletes a port forwarding rule
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the port forwarding rule
#
sub deletePortForwardingRule {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deletePortForwardingRule', $args);
}

# Creates a firewall rule for a given ip address
#
# @param array $args An associative array. The following are options for keys:
#     ipaddressid - the IP address id of the port forwarding rule
#     protocol - the protocol for the firewall rule. Valid values are
#        TCP/UDP/ICMP.
#     cidrlist - the cidr list to forward traffic from
#     endport - the ending port of firewall rule
#     icmpcode - error code for this icmp message
#     icmptype - type of the icmp message being sent
#     startport - the starting port of firewall rule
#
sub createFirewallRule {
    my ($self, $args) = @_;
    die("Missing required argument 'ipaddressid'") if(!defined($args->{'ipaddressid'}));
    die("Missing required argument 'protocol'") if(!defined($args->{'protocol'}));

    return $self->request('createFirewallRule', $args);
}

# Deletes a firewall rule
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the firewall rule
#
sub deleteFirewallRule {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteFirewallRule', $args);
}

# Lists all firewall rules for an IP address.
#
# @param array $args An associative array. The following are options for keys:
#     account - account. Must be used with the domainId parameter.
#     domainid - the domain ID. If used with the account parameter, lists firewall
#        rules for the specified account in this domain.
#     id - Lists rule with the specified ID.
#     ipaddressid - the id of IP address of the firwall services
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     page - Pagination
#
sub listFirewallRules {
    my ($self, $args) = @_;

    return $self->request('listFirewallRules', $args);
}

# Enables static nat for given ip address
#
# @param array $args An associative array. The following are options for keys:
#     ipaddressid - the public IP address id for which static nat feature is being
#        enabled
#     virtualmachineid - the ID of the virtual machine for enabling static nat
#        feature
#
sub enableStaticNat {
    my ($self, $args) = @_;
    die("Missing required argument 'ipaddressid'") if(!defined($args->{'ipaddressid'}));
    die("Missing required argument 'virtualmachineid'") if(!defined($args->{'virtualmachineid'}));

    return $self->request('enableStaticNat', $args);
}

# Creates an ip forwarding rule
#
# @param array $args An associative array. The following are options for keys:
#     ipaddressid - the public IP address id of the forwarding rule, already
#        associated via associateIp
#     protocol - the protocol for the rule. Valid values are TCP or UDP.
#     startport - the start port for the rule
#     cidrlist - the cidr list to forward traffic from
#     endport - the end port for the rule
#     openfirewall - if true, firewall rule for source/end pubic port is
#        automatically created; if false - firewall rule has to be created explicitely.
#        Has value true by default
#
sub createIpForwardingRule {
    my ($self, $args) = @_;
    die("Missing required argument 'ipaddressid'") if(!defined($args->{'ipaddressid'}));
    die("Missing required argument 'protocol'") if(!defined($args->{'protocol'}));
    die("Missing required argument 'startport'") if(!defined($args->{'startport'}));

    return $self->request('createIpForwardingRule', $args);
}

# Deletes an ip forwarding rule
#
# @param array $args An associative array. The following are options for keys:
#     id - the id of the forwarding rule
#
sub deleteIpForwardingRule {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteIpForwardingRule', $args);
}

# List the ip forwarding rules
#
# @param array $args An associative array. The following are options for keys:
#     account - the account associated with the ip forwarding rule. Must be used
#        with the domainId parameter.
#     domainid - Lists all rules for this id. If used with the account parameter,
#        returns all rules for an account in the specified domain ID.
#     id - Lists rule with the specified ID.
#     ipaddressid - list the rule belonging to this public ip address
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     virtualmachineid - Lists all rules applied to the specified Vm.
#     page - Pagination
#
sub listIpForwardingRules {
    my ($self, $args) = @_;

    return $self->request('listIpForwardingRules', $args);
}

# Disables static rule for given ip address
#
# @param array $args An associative array. The following are options for keys:
#     ipaddressid - the public IP address id for which static nat feature is being
#        disableed
#
sub disableStaticNat {
    my ($self, $args) = @_;
    die("Missing required argument 'ipaddressid'") if(!defined($args->{'ipaddressid'}));

    return $self->request('disableStaticNat', $args);
}

# Creates a load balancer rule
#
# @param array $args An associative array. The following are options for keys:
#     algorithm - load balancer algorithm (source, roundrobin, leastconn)
#     name - name of the load balancer rule
#     privateport - the private port of the private ip address/virtual machine
#        where the network traffic will be load balanced to
#     publicport - the public port from where the network traffic will be load
#        balanced from
#     account - the account associated with the load balancer. Must be used with
#        the domainId parameter.
#     cidrlist - the cidr list to forward traffic from
#     description - the description of the load balancer rule
#     domainid - the domain ID associated with the load balancer
#     openfirewall - if true, firewall rule for source/end pubic port is
#        automatically created; if false - firewall rule has to be created explicitely.
#        Has value true by default
#     publicipid - public ip address id from where the network traffic will be
#        load balanced from
#     zoneid - public ip address id from where the network traffic will be load
#        balanced from
#
sub createLoadBalancerRule {
    my ($self, $args) = @_;
    die("Missing required argument 'algorithm'") if(!defined($args->{'algorithm'}));
    die("Missing required argument 'name'") if(!defined($args->{'name'}));
    die("Missing required argument 'privateport'") if(!defined($args->{'privateport'}));
    die("Missing required argument 'publicport'") if(!defined($args->{'publicport'}));

    return $self->request('createLoadBalancerRule', $args);
}

# Deletes a load balancer rule.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the load balancer rule
#
sub deleteLoadBalancerRule {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteLoadBalancerRule', $args);
}

# Removes a virtual machine or a list of virtual machines from a load balancer
# rule.
#
# @param array $args An associative array. The following are options for keys:
#     id - The ID of the load balancer rule
#     virtualmachineids - the list of IDs of the virtual machines that are being
#        removed from the load balancer rule (i.e. virtualMachineIds=1,2,3)
#
sub removeFromLoadBalancerRule {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));
    die("Missing required argument 'virtualmachineids'") if(!defined($args->{'virtualmachineids'}));

    return $self->request('removeFromLoadBalancerRule', $args);
}

# Assigns virtual machine or a list of virtual machines to a load balancer rule.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the load balancer rule
#     virtualmachineids - the list of IDs of the virtual machine that are being
#        assigned to the load balancer rule(i.e. virtualMachineIds=1,2,3)
#
sub assignToLoadBalancerRule {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));
    die("Missing required argument 'virtualmachineids'") if(!defined($args->{'virtualmachineids'}));

    return $self->request('assignToLoadBalancerRule', $args);
}

# Lists load balancer rules.
#
# @param array $args An associative array. The following are options for keys:
#     account - the account of the load balancer rule. Must be used with the
#        domainId parameter.
#     domainid - the domain ID of the load balancer rule. If used with the account
#        parameter, lists load balancer rules for the account in the specified domain.
#     id - the ID of the load balancer rule
#     keyword - List by keyword
#     name - the name of the load balancer rule
#     page - 
#     pagesize - 
#     publicipid - the public IP address id of the load balancer rule
#     virtualmachineid - the ID of the virtual machine of the load balancer rule
#     zoneid - the availability zone ID
#     page - Pagination
#
sub listLoadBalancerRules {
    my ($self, $args) = @_;

    return $self->request('listLoadBalancerRules', $args);
}

# List all virtual machine instances that are assigned to a load balancer rule.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the load balancer rule
#     applied - true if listing all virtual machines currently applied to the load
#        balancer rule; default is true
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     page - Pagination
#
sub listLoadBalancerRuleInstances {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('listLoadBalancerRuleInstances', $args);
}

# Updates load balancer
#
# @param array $args An associative array. The following are options for keys:
#     id - the id of the load balancer rule to update
#     algorithm - load balancer algorithm (source, roundrobin, leastconn)
#     description - the description of the load balancer rule
#     name - the name of the load balancer rule
#
sub updateLoadBalancerRule {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('updateLoadBalancerRule', $args);
}

# Starts a router.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the router
#
sub startRouter {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('startRouter', $args);
}

# Starts a router.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the router
#
sub rebootRouter {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('rebootRouter', $args);
}

# Stops a router.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the router
#     forced - Force stop the VM. The caller knows the VM is stopped.
#
sub stopRouter {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('stopRouter', $args);
}

# Destroys a router.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the router
#
sub destroyRouter {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('destroyRouter', $args);
}

# Upgrades domain router to a new service offering
#
# @param array $args An associative array. The following are options for keys:
#     id - The ID of the router
#     serviceofferingid - the service offering ID to apply to the domain router
#
sub changeServiceForRouter {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));
    die("Missing required argument 'serviceofferingid'") if(!defined($args->{'serviceofferingid'}));

    return $self->request('changeServiceForRouter', $args);
}

# List routers.
#
# @param array $args An associative array. The following are options for keys:
#     account - the name of the account associated with the router. Must be used
#        with the domainId parameter.
#     domainid - the domain ID associated with the router. If used with the
#        account parameter, lists all routers associated with an account in the specified
#        domain.
#     hostid - the host ID of the router
#     id - the ID of the disk router
#     keyword - List by keyword
#     name - the name of the router
#     networkid - list by network id
#     page - 
#     pagesize - 
#     podid - the Pod ID of the router
#     state - the state of the router
#     zoneid - the Zone ID of the router
#     page - Pagination
#
sub listRouters {
    my ($self, $args) = @_;

    return $self->request('listRouters', $args);
}

# Starts a system virtual machine.
#
# @param array $args An associative array. The following are options for keys:
#     id - The ID of the system virtual machine
#
sub startSystemVm {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('startSystemVm', $args);
}

# Reboots a system VM.
#
# @param array $args An associative array. The following are options for keys:
#     id - The ID of the system virtual machine
#
sub rebootSystemVm {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('rebootSystemVm', $args);
}

# Stops a system VM.
#
# @param array $args An associative array. The following are options for keys:
#     id - The ID of the system virtual machine
#     forced - Force stop the VM.  The caller knows the VM is stopped.
#
sub stopSystemVm {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('stopSystemVm', $args);
}

# Destroyes a system virtual machine.
#
# @param array $args An associative array. The following are options for keys:
#     id - The ID of the system virtual machine
#
sub destroySystemVm {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('destroySystemVm', $args);
}

# List system virtual machines.
#
# @param array $args An associative array. The following are options for keys:
#     hostid - the host ID of the system VM
#     id - the ID of the system VM
#     keyword - List by keyword
#     name - the name of the system VM
#     page - 
#     pagesize - 
#     podid - the Pod ID of the system VM
#     state - the state of the system VM
#     systemvmtype - the system VM type. Possible types are "consoleproxy" and
#        "secondarystoragevm".
#     zoneid - the Zone ID of the system VM
#     page - Pagination
#
sub listSystemVms {
    my ($self, $args) = @_;

    return $self->request('listSystemVms', $args);
}

# Updates a configuration.
#
# @param array $args An associative array. The following are options for keys:
#     name - the name of the configuration
#     value - the value of the configuration
#
sub updateConfiguration {
    my ($self, $args) = @_;
    die("Missing required argument 'name'") if(!defined($args->{'name'}));

    return $self->request('updateConfiguration', $args);
}

# Lists all configurations.
#
# @param array $args An associative array. The following are options for keys:
#     category - lists configurations by category
#     keyword - List by keyword
#     name - lists configuration by name
#     page - 
#     pagesize - 
#     page - Pagination
#
sub listConfigurations {
    my ($self, $args) = @_;

    return $self->request('listConfigurations', $args);
}

# Adds configuration value
#
# @param array $args An associative array. The following are options for keys:
#     category - component's category
#     component - the component of the configuration
#     instance - the instance of the configuration
#     name - the name of the configuration
#     description - the description of the configuration
#     value - the value of the configuration
#
sub createConfiguration {
    my ($self, $args) = @_;
    die("Missing required argument 'category'") if(!defined($args->{'category'}));
    die("Missing required argument 'component'") if(!defined($args->{'component'}));
    die("Missing required argument 'instance'") if(!defined($args->{'instance'}));
    die("Missing required argument 'name'") if(!defined($args->{'name'}));

    return $self->request('createConfiguration', $args);
}

# Lists capabilities
#
# @param array $args An associative array. The following are options for keys:
#     page - Pagination
#
sub listCapabilities {
    my ($self, $args) = @_;

    return $self->request('listCapabilities', $args);
}

# Creates a new Pod.
#
# @param array $args An associative array. The following are options for keys:
#     gateway - the gateway for the Pod
#     name - the name of the Pod
#     netmask - the netmask for the Pod
#     startip - the starting IP address for the Pod
#     zoneid - the Zone ID in which the Pod will be created
#     allocationstate - Allocation state of this Pod for allocation of new
#        resources
#     endip - the ending IP address for the Pod
#
sub createPod {
    my ($self, $args) = @_;
    die("Missing required argument 'gateway'") if(!defined($args->{'gateway'}));
    die("Missing required argument 'name'") if(!defined($args->{'name'}));
    die("Missing required argument 'netmask'") if(!defined($args->{'netmask'}));
    die("Missing required argument 'startip'") if(!defined($args->{'startip'}));
    die("Missing required argument 'zoneid'") if(!defined($args->{'zoneid'}));

    return $self->request('createPod', $args);
}

# Updates a Pod.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the Pod
#     allocationstate - Allocation state of this cluster for allocation of new
#        resources
#     endip - the ending IP address for the Pod
#     gateway - the gateway for the Pod
#     name - the name of the Pod
#     netmask - the netmask of the Pod
#     startip - the starting IP address for the Pod
#
sub updatePod {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('updatePod', $args);
}

# Deletes a Pod.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the Pod
#
sub deletePod {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deletePod', $args);
}

# Lists all Pods.
#
# @param array $args An associative array. The following are options for keys:
#     allocationstate - list pods by allocation state
#     id - list Pods by ID
#     keyword - List by keyword
#     name - list Pods by name
#     page - 
#     pagesize - 
#     zoneid - list Pods by Zone ID
#     page - Pagination
#
sub listPods {
    my ($self, $args) = @_;

    return $self->request('listPods', $args);
}

# Creates a Zone.
#
# @param array $args An associative array. The following are options for keys:
#     dns1 - the first DNS for the Zone
#     internaldns1 - the first internal DNS for the Zone
#     name - the name of the Zone
#     networktype - network type of the zone, can be Basic or Advanced
#     allocationstate - Allocation state of this Zone for allocation of new
#        resources
#     dns2 - the second DNS for the Zone
#     domain - Network domain name for the networks in the zone
#     domainid - the ID of the containing domain, null for public zones
#     guestcidraddress - the guest CIDR address for the Zone
#     internaldns2 - the second internal DNS for the Zone
#     securitygroupenabled - true if network is security group enabled, false
#        otherwise
#     vlan - the VLAN for the Zone
#
sub createZone {
    my ($self, $args) = @_;
    die("Missing required argument 'dns1'") if(!defined($args->{'dns1'}));
    die("Missing required argument 'internaldns1'") if(!defined($args->{'internaldns1'}));
    die("Missing required argument 'name'") if(!defined($args->{'name'}));
    die("Missing required argument 'networktype'") if(!defined($args->{'networktype'}));

    return $self->request('createZone', $args);
}

# Updates a Zone.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the Zone
#     allocationstate - Allocation state of this cluster for allocation of new
#        resources
#     details - the details for the Zone
#     dhcpprovider - the dhcp Provider for the Zone
#     dns1 - the first DNS for the Zone
#     dns2 - the second DNS for the Zone
#     dnssearchorder - the dns search order list
#     domain - Network domain name for the networks in the zone
#     guestcidraddress - the guest CIDR address for the Zone
#     internaldns1 - the first internal DNS for the Zone
#     internaldns2 - the second internal DNS for the Zone
#     ispublic - updates a private zone to public if set, but not vice-versa
#     name - the name of the Zone
#     vlan - the VLAN for the Zone
#
sub updateZone {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('updateZone', $args);
}

# Deletes a Zone.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the Zone
#
sub deleteZone {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteZone', $args);
}

# Lists zones
#
# @param array $args An associative array. The following are options for keys:
#     available - true if you want to retrieve all available Zones. False if you
#        only want to return the Zones from which you have at least one VM. Default is
#        false.
#     domainid - the ID of the domain associated with the zone
#     id - the ID of the zone
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     page - Pagination
#
sub listZones {
    my ($self, $args) = @_;

    return $self->request('listZones', $args);
}

# Updates a network offering.
#
# @param array $args An associative array. The following are options for keys:
#     availability - the availability of network offering. Default value is
#        Required for Guest Virtual network offering; Optional for Guest Direct network
#        offering
#     displaytext - the display text of the network offering
#     id - the id of the network offering
#     name - the name of the network offering
#
sub updateNetworkOffering {
    my ($self, $args) = @_;

    return $self->request('updateNetworkOffering', $args);
}

# Lists all available network offerings.
#
# @param array $args An associative array. The following are options for keys:
#     availability - the availability of network offering. Default value is
#        Required
#     displaytext - list network offerings by display text
#     guestiptype - the guest ip type for the network offering, supported types
#        are Direct and Virtual.
#     id - list network offerings by id
#     isdefault - true if need to list only default network offerings. Default
#        value is false
#     isshared - true is network offering supports vlans
#     keyword - List by keyword
#     name - list network offerings by name
#     page - 
#     pagesize - 
#     specifyvlan - the tags for the network offering.
#     traffictype - list by traffic type
#     zoneid - list netowrk offerings available for network creation in specific
#        zone
#     page - Pagination
#
sub listNetworkOfferings {
    my ($self, $args) = @_;

    return $self->request('listNetworkOfferings', $args);
}

# Creates a network
#
# @param array $args An associative array. The following are options for keys:
#     displaytext - the display text of the network
#     name - the name of the network
#     networkofferingid - the network offering id
#     zoneid - the Zone ID for the network
#     account - account who will own the network
#     domainid - domain ID of the account owning a network
#     endip - the ending IP address in the network IP range. If not specified,
#        will be defaulted to startIP
#     gateway - the gateway of the network
#     isdefault - true if network is default, false otherwise
#     isshared - true is network is shared across accounts in the Zone
#     netmask - the netmask of the network
#     networkdomain - network domain
#     startip - the beginning IP address in the network IP range
#     tags - Tag the network
#     vlan - the ID or VID of the network
#
sub createNetwork {
    my ($self, $args) = @_;
    die("Missing required argument 'displaytext'") if(!defined($args->{'displaytext'}));
    die("Missing required argument 'name'") if(!defined($args->{'name'}));
    die("Missing required argument 'networkofferingid'") if(!defined($args->{'networkofferingid'}));
    die("Missing required argument 'zoneid'") if(!defined($args->{'zoneid'}));

    return $self->request('createNetwork', $args);
}

# Deletes a network
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the network
#
sub deleteNetwork {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteNetwork', $args);
}

# Lists all available networks.
#
# @param array $args An associative array. The following are options for keys:
#     account - account who will own the VLAN. If VLAN is Zone wide, this
#        parameter should be ommited
#     domainid - domain ID of the account owning a VLAN
#     id - list networks by id
#     isdefault - true if network is default, false otherwise
#     isshared - true if network is shared across accounts in the Zone, false
#        otherwise
#     issystem - true if network is system, false otherwise
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     traffictype - type of the traffic
#     type - the type of the network
#     zoneid - the Zone ID of the network
#     page - Pagination
#
sub listNetworks {
    my ($self, $args) = @_;

    return $self->request('listNetworks', $args);
}

# Restarts the network; includes 1) restarting network elements - virtual routers,
# dhcp servers 2) reapplying all public ips 3) reapplying
# loadBalancing/portForwarding rules
#
# @param array $args An associative array. The following are options for keys:
#     id - The id of the network to restart.
#     cleanup - If cleanup old network elements
#
sub restartNetwork {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('restartNetwork', $args);
}

# Updates a network
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the network
#     displaytext - the new display text for the network
#     name - the new name for the network
#     networkdomain - network domain
#     tags - tags for the network
#
sub updateNetwork {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('updateNetwork', $args);
}

# Creates a l2tp/ipsec remote access vpn
#
# @param array $args An associative array. The following are options for keys:
#     publicipid - public ip address id of the vpn server
#     account - an optional account for the VPN. Must be used with domainId.
#     domainid - an optional domainId for the VPN. If the account parameter is
#        used, domainId must also be used.
#     iprange - the range of ip addresses to allocate to vpn clients. The first ip
#        in the range will be taken by the vpn server
#     openfirewall - if true, firewall rule for source/end pubic port is
#        automatically created; if false - firewall rule has to be created explicitely.
#        Has value true by default
#
sub createRemoteAccessVpn {
    my ($self, $args) = @_;
    die("Missing required argument 'publicipid'") if(!defined($args->{'publicipid'}));

    return $self->request('createRemoteAccessVpn', $args);
}

# Destroys a l2tp/ipsec remote access vpn
#
# @param array $args An associative array. The following are options for keys:
#     publicipid - public ip address id of the vpn server
#
sub deleteRemoteAccessVpn {
    my ($self, $args) = @_;
    die("Missing required argument 'publicipid'") if(!defined($args->{'publicipid'}));

    return $self->request('deleteRemoteAccessVpn', $args);
}

# Lists remote access vpns
#
# @param array $args An associative array. The following are options for keys:
#     publicipid - public ip address id of the vpn server
#     account - the account of the remote access vpn. Must be used with the
#        domainId parameter.
#     domainid - the domain ID of the remote access vpn rule. If used with the
#        account parameter, lists remote access vpns for the account in the specified
#        domain.
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     page - Pagination
#
sub listRemoteAccessVpns {
    my ($self, $args) = @_;
    die("Missing required argument 'publicipid'") if(!defined($args->{'publicipid'}));

    return $self->request('listRemoteAccessVpns', $args);
}

# Adds vpn users
#
# @param array $args An associative array. The following are options for keys:
#     password - password for the username
#     username - username for the vpn user
#     account - an optional account for the vpn user. Must be used with domainId.
#     domainid - an optional domainId for the vpn user. If the account parameter
#        is used, domainId must also be used.
#
sub addVpnUser {
    my ($self, $args) = @_;
    die("Missing required argument 'password'") if(!defined($args->{'password'}));
    die("Missing required argument 'username'") if(!defined($args->{'username'}));

    return $self->request('addVpnUser', $args);
}

# Removes vpn user
#
# @param array $args An associative array. The following are options for keys:
#     username - username for the vpn user
#     account - an optional account for the vpn user. Must be used with domainId.
#     domainid - an optional domainId for the vpn user. If the account parameter
#        is used, domainId must also be used.
#
sub removeVpnUser {
    my ($self, $args) = @_;
    die("Missing required argument 'username'") if(!defined($args->{'username'}));

    return $self->request('removeVpnUser', $args);
}

# Lists vpn users
#
# @param array $args An associative array. The following are options for keys:
#     account - the account of the remote access vpn. Must be used with the
#        domainId parameter.
#     domainid - the domain ID of the remote access vpn. If used with the account
#        parameter, lists remote access vpns for the account in the specified domain.
#     id - the ID of the vpn user
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     username - the username of the vpn user.
#     page - Pagination
#
sub listVpnUsers {
    my ($self, $args) = @_;

    return $self->request('listVpnUsers', $args);
}

# Updates resource limits for an account or domain.
#
# @param array $args An associative array. The following are options for keys:
#     resourcetype - Type of resource to update. Values are 0, 1, 2, 3, and 4. 0 -
#        Instance. Number of instances a user can create. 1 - IP. Number of public IP
#        addresses a user can own. 2 - Volume. Number of disk volumes a user can create.3
#        - Snapshot. Number of snapshots a user can create.4 - Template. Number of
#        templates that a user can register/create.
#     account - Update resource for a specified account. Must be used with the
#        domainId parameter.
#     domainid - Update resource limits for all accounts in specified domain. If
#        used with the account parameter, updates resource limits for a specified account
#        in specified domain.
#     max - Maximum resource limit.
#
sub updateResourceLimit {
    my ($self, $args) = @_;
    die("Missing required argument 'resourcetype'") if(!defined($args->{'resourcetype'}));

    return $self->request('updateResourceLimit', $args);
}

# Recalculate and update resource count for an account or domain.
#
# @param array $args An associative array. The following are options for keys:
#     domainid - If account parameter specified then updates resource counts for a
#        specified account in this domain else update resource counts for all accounts &
#        child domains in specified domain.
#     account - Update resource count for a specified account. Must be used with
#        the domainId parameter.
#     resourcetype - Type of resource to update. If specifies valid values are 0,
#        1, 2, 3, and 4. If not specified will update all resource counts0 - Instance.
#        Number of instances a user can create. 1 - IP. Number of public IP addresses a
#        user can own. 2 - Volume. Number of disk volumes a user can create.3 - Snapshot.
#        Number of snapshots a user can create.4 - Template. Number of templates that a
#        user can register/create.
#
sub updateResourceCount {
    my ($self, $args) = @_;
    die("Missing required argument 'domainid'") if(!defined($args->{'domainid'}));

    return $self->request('updateResourceCount', $args);
}

# Lists resource limits.
#
# @param array $args An associative array. The following are options for keys:
#     account - Lists resource limits by account. Must be used with the domainId
#        parameter.
#     domainid - Lists resource limits by domain ID. If used with the account
#        parameter, lists resource limits for a specified account in a specified domain.
#     id - Lists resource limits by ID.
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     resourcetype - Type of resource to update. Values are 0, 1, 2, 3, and 4. 0 -
#        Instance. Number of instances a user can create. 1 - IP. Number of public IP
#        addresses a user can own. 2 - Volume. Number of disk volumes a user can create.3
#        - Snapshot. Number of snapshots a user can create.4 - Template. Number of
#        templates that a user can register/create.
#     page - Pagination
#
sub listResourceLimits {
    my ($self, $args) = @_;

    return $self->request('listResourceLimits', $args);
}

# Retrieves a cloud identifier.
#
# @param array $args An associative array. The following are options for keys:
#     userid - the user ID for the cloud identifier
#
sub getCloudIdentifier {
    my ($self, $args) = @_;
    die("Missing required argument 'userid'") if(!defined($args->{'userid'}));

    return $self->request('getCloudIdentifier', $args);
}

# This command allows a user to register for the developer API, returning a secret
# key and an API key. This request is made through the integration API port, so it
# is a privileged command and must be made on behalf of a user. It is up to the
# implementer just how the username and password are entered, and then how that
# translates to an integration API request. Both secret key and API key should be
# returned to the user
#
# @param array $args An associative array. The following are options for keys:
#     id - User id
#
sub registerUserKeys {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('registerUserKeys', $args);
}

# Creates a vm group
#
# @param array $args An associative array. The following are options for keys:
#     name - the name of the instance group
#     account - the account of the instance group. The account parameter must be
#        used with the domainId parameter.
#     domainid - the domain ID of account owning the instance group
#
sub createInstanceGroup {
    my ($self, $args) = @_;
    die("Missing required argument 'name'") if(!defined($args->{'name'}));

    return $self->request('createInstanceGroup', $args);
}

# Deletes a vm group
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the instance group
#
sub deleteInstanceGroup {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteInstanceGroup', $args);
}

# Updates a vm group
#
# @param array $args An associative array. The following are options for keys:
#     id - Instance group ID
#     name - new instance group name
#
sub updateInstanceGroup {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('updateInstanceGroup', $args);
}

# Lists vm groups
#
# @param array $args An associative array. The following are options for keys:
#     account - list instance group belonging to the specified account. Must be
#        used with domainid parameter
#     domainid - the domain ID. If used with the account parameter, lists virtual
#        machines for the specified account in this domain.
#     id - list instance groups by ID
#     keyword - List by keyword
#     name - list instance groups by name
#     page - 
#     pagesize - 
#     page - Pagination
#
sub listInstanceGroups {
    my ($self, $args) = @_;

    return $self->request('listInstanceGroups', $args);
}

# Lists storage pools.
#
# @param array $args An associative array. The following are options for keys:
#     clusterid - list storage pools belongig to the specific cluster
#     id - the ID of the storage pool
#     ipaddress - the IP address for the storage pool
#     keyword - List by keyword
#     name - the name of the storage pool
#     page - 
#     pagesize - 
#     path - the storage pool path
#     podid - the Pod ID for the storage pool
#     zoneid - the Zone ID for the storage pool
#     page - Pagination
#
sub listStoragePools {
    my ($self, $args) = @_;

    return $self->request('listStoragePools', $args);
}

# Creates a storage pool.
#
# @param array $args An associative array. The following are options for keys:
#     name - the name for the storage pool
#     url - the URL of the storage pool
#     zoneid - the Zone ID for the storage pool
#     clusterid - the cluster ID for the storage pool
#     details - the details for the storage pool
#     podid - the Pod ID for the storage pool
#     tags - the tags for the storage pool
#
sub createStoragePool {
    my ($self, $args) = @_;
    die("Missing required argument 'name'") if(!defined($args->{'name'}));
    die("Missing required argument 'url'") if(!defined($args->{'url'}));
    die("Missing required argument 'zoneid'") if(!defined($args->{'zoneid'}));

    return $self->request('createStoragePool', $args);
}

# Deletes a storage pool.
#
# @param array $args An associative array. The following are options for keys:
#     id - Storage pool id
#
sub deleteStoragePool {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteStoragePool', $args);
}

# Puts storage pool into maintenance state
#
# @param array $args An associative array. The following are options for keys:
#     id - Primary storage ID
#
sub enableStorageMaintenance {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('enableStorageMaintenance', $args);
}

# Cancels maintenance for primary storage
#
# @param array $args An associative array. The following are options for keys:
#     id - the primary storage ID
#
sub cancelStorageMaintenance {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('cancelStorageMaintenance', $args);
}

# Creates a security group
#
# @param array $args An associative array. The following are options for keys:
#     name - name of the security group
#     account - an optional account for the security group. Must be used with
#        domainId.
#     description - the description of the security group
#     domainid - an optional domainId for the security group. If the account
#        parameter is used, domainId must also be used.
#
sub createSecurityGroup {
    my ($self, $args) = @_;
    die("Missing required argument 'name'") if(!defined($args->{'name'}));

    return $self->request('createSecurityGroup', $args);
}

# Deletes security group
#
# @param array $args An associative array. The following are options for keys:
#     account - the account of the security group. Must be specified with domain
#        ID
#     domainid - the domain ID of account owning the security group
#     id - The ID of the security group. Mutually exclusive with name parameter
#     name - The ID of the security group. Mutually exclusive with id parameter
#
sub deleteSecurityGroup {
    my ($self, $args) = @_;

    return $self->request('deleteSecurityGroup', $args);
}

# Authorizes a particular ingress rule for this security group
#
# @param array $args An associative array. The following are options for keys:
#     account - an optional account for the virtual machine. Must be used with
#        domainId.
#     cidrlist - the cidr list associated
#     domainid - an optional domainId for the security group. If the account
#        parameter is used, domainId must also be used.
#     endport - end port for this ingress rule
#     icmpcode - error code for this icmp message
#     icmptype - type of the icmp message being sent
#     protocol - TCP is default. UDP is the other supported protocol
#     securitygroupid - The ID of the security group. Mutually exclusive with
#        securityGroupName parameter
#     securitygroupname - The name of the security group. Mutually exclusive with
#        securityGroupName parameter
#     startport - start port for this ingress rule
#     usersecuritygrouplist - user to security group mapping
#
sub authorizeSecurityGroupIngress {
    my ($self, $args) = @_;

    return $self->request('authorizeSecurityGroupIngress', $args);
}

# Deletes a particular ingress rule from this security group
#
# @param array $args An associative array. The following are options for keys:
#     id - The ID of the ingress rule
#
sub revokeSecurityGroupIngress {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('revokeSecurityGroupIngress', $args);
}

# Lists security groups
#
# @param array $args An associative array. The following are options for keys:
#     account - lists all available port security groups for the account. Must be
#        used with domainID parameter
#     domainid - lists all available security groups for the domain ID. If used
#        with the account parameter, lists all available security groups for the account
#        in the specified domain ID.
#     id - list the security group by the id provided
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     securitygroupname - lists security groups by name
#     virtualmachineid - lists security groups by virtual machine id
#     page - Pagination
#
sub listSecurityGroups {
    my ($self, $args) = @_;

    return $self->request('listSecurityGroups', $args);
}

# Register a public key in a keypair under a certain name
#
# @param array $args An associative array. The following are options for keys:
#     name - Name of the keypair
#     publickey - Public key material of the keypair
#     account - an optional account for the ssh key. Must be used with domainId.
#     domainid - an optional domainId for the ssh key. If the account parameter is
#        used, domainId must also be used.
#
sub registerSSHKeyPair {
    my ($self, $args) = @_;
    die("Missing required argument 'name'") if(!defined($args->{'name'}));
    die("Missing required argument 'publickey'") if(!defined($args->{'publickey'}));

    return $self->request('registerSSHKeyPair', $args);
}

# Create a new keypair and returns the private key
#
# @param array $args An associative array. The following are options for keys:
#     name - Name of the keypair
#     account - an optional account for the ssh key. Must be used with domainId.
#     domainid - an optional domainId for the ssh key. If the account parameter is
#        used, domainId must also be used.
#
sub createSSHKeyPair {
    my ($self, $args) = @_;
    die("Missing required argument 'name'") if(!defined($args->{'name'}));

    return $self->request('createSSHKeyPair', $args);
}

# Deletes a keypair by name
#
# @param array $args An associative array. The following are options for keys:
#     name - Name of the keypair
#     account - the account associated with the keypair. Must be used with the
#        domainId parameter.
#     domainid - the domain ID associated with the keypair
#
sub deleteSSHKeyPair {
    my ($self, $args) = @_;
    die("Missing required argument 'name'") if(!defined($args->{'name'}));

    return $self->request('deleteSSHKeyPair', $args);
}

# List registered keypairs
#
# @param array $args An associative array. The following are options for keys:
#     fingerprint - A public key fingerprint to look for
#     keyword - List by keyword
#     name - A key pair name to look for
#     page - 
#     pagesize - 
#     page - Pagination
#
sub listSSHKeyPairs {
    my ($self, $args) = @_;

    return $self->request('listSSHKeyPairs', $args);
}

# Retrieves the current status of asynchronous job.
#
# @param array $args An associative array. The following are options for keys:
#     jobid - the ID of the asychronous job
#
sub queryAsyncJobResult {
    my ($self, $args) = @_;
    die("Missing required argument 'jobid'") if(!defined($args->{'jobid'}));

    return $self->request('queryAsyncJobResult', $args);
}

# Lists all pending asynchronous jobs for the account.
#
# @param array $args An associative array. The following are options for keys:
#     account - the account associated with the async job. Must be used with the
#        domainId parameter.
#     domainid - the domain ID associated with the async job.  If used with the
#        account parameter, returns async jobs for the account in the specified domain.
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     startdate - the start date of the async job
#     page - Pagination
#
sub listAsyncJobs {
    my ($self, $args) = @_;

    return $self->request('listAsyncJobs', $args);
}

# Uploads custom certificate
#
# @param array $args An associative array. The following are options for keys:
#     certificate - the custom cert to be uploaded
#     domainsuffix - DNS domain suffix that the certificate is granted for
#     privatekey - the private key for the certificate
#
sub uploadCustomCertificate {
    my ($self, $args) = @_;
    die("Missing required argument 'certificate'") if(!defined($args->{'certificate'}));
    die("Missing required argument 'domainsuffix'") if(!defined($args->{'domainsuffix'}));
    die("Missing required argument 'privatekey'") if(!defined($args->{'privatekey'}));

    return $self->request('uploadCustomCertificate', $args);
}

# List hypervisors
#
# @param array $args An associative array. The following are options for keys:
#     zoneid - the zone id for listing hypervisors.
#     page - Pagination
#
sub listHypervisors {
    my ($self, $args) = @_;

    return $self->request('listHypervisors', $args);
}

# Lists all alerts.
#
# @param array $args An associative array. The following are options for keys:
#     id - the ID of the alert
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     type - list by alert type
#     page - Pagination
#
sub listAlerts {
    my ($self, $args) = @_;

    return $self->request('listAlerts', $args);
}

# A command to list events.
#
# @param array $args An associative array. The following are options for keys:
#     account - the account for the event. Must be used with the domainId
#        parameter.
#     domainid - the domain ID for the event. If used with the account parameter,
#        returns all events for an account in the specified domain ID.
#     duration - the duration of the event
#     enddate - the end date range of the list you want to retrieve (use format
#        "yyyy-MM-dd" or the new format "yyyy-MM-dd HH:mm:ss")
#     entrytime - the time the event was entered
#     id - the ID of the event
#     keyword - List by keyword
#     level - the event level (INFO, WARN, ERROR)
#     page - 
#     pagesize - 
#     startdate - the start date range of the list you want to retrieve (use
#        format "yyyy-MM-dd" or the new format "yyyy-MM-dd HH:mm:ss")
#     type - the event type (see event types)
#     page - Pagination
#
sub listEvents {
    my ($self, $args) = @_;

    return $self->request('listEvents', $args);
}

# List Event Types
#
# @param array $args An associative array. The following are options for keys:
#     page - Pagination
#
sub listEventTypes {
    my ($self, $args) = @_;

    return $self->request('listEventTypes', $args);
}

# Logs a user into the CloudStack. A successful login attempt will generate a
# JSESSIONID cookie value that can be passed in subsequent Query command calls
# until the "logout" command has been issued or the session has expired.
#
# @param array $args An associative array. The following are options for keys:
#     username - Username
#     password - Hashed password (Default is MD5). If you wish to use any other
#        hashing algorithm, you would need to write a custom authentication adapter See
#        Docs section.
#     domain - path of the domain that the user belongs to. Example:
#        domain=/com/cloud/internal.  If no domain is passed in, the ROOT domain is
#        assumed.
#
sub login {
    my ($self, $args) = @_;
    die("Missing required argument 'username'") if(!defined($args->{'username'}));
    die("Missing required argument 'password'") if(!defined($args->{'password'}));

    return $self->request('login', $args);
}

# Logs out the user
#
# @param array $args An associative array. The following are options for keys:
#
sub logout {
    my ($self, $args) = @_;

    return $self->request('logout', $args);
}

# Lists capacity.
#
# @param array $args An associative array. The following are options for keys:
#     hostid - lists capacity by the Host ID
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     podid - lists capacity by the Pod ID
#     type - lists capacity by type
#     zoneid - lists capacity by the Zone ID
#     page - Pagination
#
sub listCapacity {
    my ($self, $args) = @_;

    return $self->request('listCapacity', $args);
}

# List external load balancer appliances.
#
# @param array $args An associative array. The following are options for keys:
#     networkdeviceparameterlist - parameters for network device
#     networkdevicetype - Network device type, now supports ExternalDhcp,
#        ExternalFirewall, ExternalLoadBalancer, PxeServer
#
sub addNetworkDevice {
    my ($self, $args) = @_;

    return $self->request('addNetworkDevice', $args);
}

# List network device.
#
# @param array $args An associative array. The following are options for keys:
#     keyword - List by keyword
#     networkdeviceparameterlist - parameters for network device
#     networkdevicetype - Network device type, now supports ExternalDhcp,
#        ExternalFirewall, ExternalLoadBalancer, PxeServer
#     page - 
#     pagesize - 
#     page - Pagination
#
sub listNetworkDevice {
    my ($self, $args) = @_;

    return $self->request('listNetworkDevice', $args);
}

# Delete network device.
#
# @param array $args An associative array. The following are options for keys:
#     id - Id of network device to delete
#
sub deleteNetworkDevice {
    my ($self, $args) = @_;

    return $self->request('deleteNetworkDevice', $args);
}

# Adds an external load balancer appliance.
#
# @param array $args An associative array. The following are options for keys:
#     password - Password of the external load balancer appliance.
#     url - URL of the external load balancer appliance.
#     username - Username of the external load balancer appliance.
#     zoneid - Zone in which to add the external load balancer appliance.
#
sub addExternalLoadBalancer {
    my ($self, $args) = @_;
    die("Missing required argument 'password'") if(!defined($args->{'password'}));
    die("Missing required argument 'url'") if(!defined($args->{'url'}));
    die("Missing required argument 'username'") if(!defined($args->{'username'}));
    die("Missing required argument 'zoneid'") if(!defined($args->{'zoneid'}));

    return $self->request('addExternalLoadBalancer', $args);
}

# Deletes an external load balancer appliance.
#
# @param array $args An associative array. The following are options for keys:
#     id - Id of the external loadbalancer appliance.
#
sub deleteExternalLoadBalancer {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteExternalLoadBalancer', $args);
}

# List external load balancer appliances.
#
# @param array $args An associative array. The following are options for keys:
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     zoneid - zone Id
#     page - Pagination
#
sub listExternalLoadBalancers {
    my ($self, $args) = @_;

    return $self->request('listExternalLoadBalancers', $args);
}

# Adds an external firewall appliance
#
# @param array $args An associative array. The following are options for keys:
#     password - Password of the external firewall appliance.
#     url - URL of the external firewall appliance.
#     username - Username of the external firewall appliance.
#     zoneid - Zone in which to add the external firewall appliance.
#
sub addExternalFirewall {
    my ($self, $args) = @_;
    die("Missing required argument 'password'") if(!defined($args->{'password'}));
    die("Missing required argument 'url'") if(!defined($args->{'url'}));
    die("Missing required argument 'username'") if(!defined($args->{'username'}));
    die("Missing required argument 'zoneid'") if(!defined($args->{'zoneid'}));

    return $self->request('addExternalFirewall', $args);
}

# Deletes an external firewall appliance.
#
# @param array $args An associative array. The following are options for keys:
#     id - Id of the external firewall appliance.
#
sub deleteExternalFirewall {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteExternalFirewall', $args);
}

# List external firewall appliances.
#
# @param array $args An associative array. The following are options for keys:
#     zoneid - zone Id
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     page - Pagination
#
sub listExternalFirewalls {
    my ($self, $args) = @_;
    die("Missing required argument 'zoneid'") if(!defined($args->{'zoneid'}));

    return $self->request('listExternalFirewalls', $args);
}

# Generates usage records
#
# @param array $args An associative array. The following are options for keys:
#     enddate - End date range for usage record query. Use yyyy-MM-dd as the date
#        format, e.g. startDate=2009-06-03.
#     startdate - Start date range for usage record query. Use yyyy-MM-dd as the
#        date format, e.g. startDate=2009-06-01.
#     domainid - List events for the specified domain.
#
sub generateUsageRecords {
    my ($self, $args) = @_;
    die("Missing required argument 'enddate'") if(!defined($args->{'enddate'}));
    die("Missing required argument 'startdate'") if(!defined($args->{'startdate'}));

    return $self->request('generateUsageRecords', $args);
}

# Lists usage records for accounts
#
# @param array $args An associative array. The following are options for keys:
#     enddate - End date range for usage record query. Use yyyy-MM-dd as the date
#        format, e.g. startDate=2009-06-03.
#     startdate - Start date range for usage record query. Use yyyy-MM-dd as the
#        date format, e.g. startDate=2009-06-01.
#     account - List usage records for the specified user.
#     accountid - List usage records for the specified account
#     domainid - List usage records for the specified domain.
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     page - Pagination
#
sub listUsageRecords {
    my ($self, $args) = @_;
    die("Missing required argument 'enddate'") if(!defined($args->{'enddate'}));
    die("Missing required argument 'startdate'") if(!defined($args->{'startdate'}));

    return $self->request('listUsageRecords', $args);
}

# Adds Traffic Monitor Host for Direct Network Usage
#
# @param array $args An associative array. The following are options for keys:
#     url - URL of the traffic monitor Host
#     zoneid - Zone in which to add the external firewall appliance.
#
sub addTrafficMonitor {
    my ($self, $args) = @_;
    die("Missing required argument 'url'") if(!defined($args->{'url'}));
    die("Missing required argument 'zoneid'") if(!defined($args->{'zoneid'}));

    return $self->request('addTrafficMonitor', $args);
}

# Deletes an traffic monitor host.
#
# @param array $args An associative array. The following are options for keys:
#     id - Id of the Traffic Monitor Host.
#
sub deleteTrafficMonitor {
    my ($self, $args) = @_;
    die("Missing required argument 'id'") if(!defined($args->{'id'}));

    return $self->request('deleteTrafficMonitor', $args);
}

# List traffic monitor Hosts.
#
# @param array $args An associative array. The following are options for keys:
#     zoneid - zone Id
#     keyword - List by keyword
#     page - 
#     pagesize - 
#     page - Pagination
#
sub listTrafficMonitors {
    my ($self, $args) = @_;
    die("Missing required argument 'zoneid'") if(!defined($args->{'zoneid'}));

    return $self->request('listTrafficMonitors', $args);
}

1;
