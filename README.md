# Description

Use these [Packer](https://packer.io/) templates to generate Solaris 10 boxes for different providers.

This set of templates and configuration files is meant to be used with [Packer](https://packer.io/). The latest version tested is 0.7.5 (0.7.2 worked for non Parallels builds).

# Setup

## Obtain the ISO image

Due to the distribution methods of Solaris, you will need to download this image manually as there is no automated way to do it.

You can find it from [http://www.oracle.com/technetwork/server-storage/solaris10/downloads/index.html](http://www.oracle.com/technetwork/server-storage/solaris10/downloads/index.html)

The version tested is 1/13 (Oracle Solaris 10, x86).

To use a different version you should change the iso filename and the checksum.

## Provider setup

For most providers, you would need to have the corresponding guest tools already downloaded. To do this, you just need to manually select the creation of a machine from a given ISO and select the installation of the guest tools manually so that they get downloaded locally.

After this is done, you can either abort the instance creation process or delete the instance and use these templates.


# Contents

## Templates

Three different templates are provided:

* `minimal_template.json` : this is a minimal installation of Solaris 10, without a GUI.

```
 packer build -var 'output_base=/Users/tnarik/Desktop/out2' minimal_template.json
```

* `template.json` : this is a quite complete installation of Solaris 10, with a full loaded GUI.

```
 packer build -var 'output_base=/Users/tnarik/Desktop/out2' template.json
```

* `reduced_template.json` : this is a reduced installation of Solaris 10, with a functional GUI (this is not yet completed).

```
 packer build -var 'output_base=/Users/tnarik/Desktop/out2' reduced_template.json
```

### Builders

`virtualbox`, `vmware`, `parallels` are the builder names currently supported.


## Metadata

There is a set of metadata definitions for version local support (without using VagrantCloud/Atlas).

These can be used as base, adapting the `url` paths to you working environment.


## Advice

### Speed up testing

If you are going to do several iterations of testing, it is advisable creating a script that triggers the whole chain of builds and setup.

Typically you would want to select one of the templates building statements and limit the execution to a number of builders via `-only=`, as in:

```
OUTPUT="/Users/tnarik/Desktop/out2"
packer build -force -only=virtualbox,vmware -var "output_base=${OUTPUT}" template.json
```

If you want to use version support directly from your filesystem, you can copy the metadata descriptions via: 

```
mkdir -p "${OUTPUT}/solaris10/"
cp metadata/metadata.json "${OUTPUT}/solaris10/."
```

, or:

```
mkdir -p "${OUTPUT}/solaris10-minimal/"
cp metadata/metadata.json "${OUTPUT}/solaris10-minimal/."
```

You can find the `sample_build_all.sh` script as a sample.


As a result, you would be able to add the boxes to vagrant via the metadata descriptor, selecting the desired provider directly during the import.

```
vagrant box add "${OUTPUT}/solaris10/metadata.json"
mkdir -p <folder>
cd <folder>
vagrant init tnarik/solaris10
```

And now you can edit the generated `Vagrantfile` to specify the provider in the descriptor itself to avoid verbose vagrant invocations:

```
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'vmware_fusion'
```

If you don't need or want the version support, you can also add the baseboxes directly from the file system via:

```
vagrant box add --name tnarik/solaris10 "${OUTPUT}/vagrant/solaris10-vmware.box" --force
```

### Speed up testing (via Test Kitchen)

In order to generate a box with Chef installed, so that Test Kitchen doesn't attempt downloading/installing Chef everytime, you can use the `generate_with_chef.sh` script to produce a version of the box of your choice with Chef installed.

Just take a look at the script and modify to use the base box you wish.

## Development

### Versioning

Versioning of the virtual machines takes place via the `metadata.json`. These versions should be linked to git tags, but don't expect to find version `0.0.1` there.

Between versions, the `metadata.json` files could reflect any version number (released version or future version) but should reflect the future one (the one being developed, even if there is no active development on it).

## Caveats
### VMWare

When creating a vagrant box base on the VMware provider, the `pcislotnumber` needs to be forcefully set in the `Vagrantfile` to the same value used by the basebox, via:

```
vb.vmx["ethernet0.pcislotnumber"] = "33"
```

It looks like the Vagrant VMware Fusion Plugin uses a template to recreate the vmx file (or at least in some conditions), and this messes up with the interface names, resulting in a non-networked box.  