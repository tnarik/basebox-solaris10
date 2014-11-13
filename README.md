# Obtain the ISO image

You need to download this image manually as there is no automated way to do it.

You can find it from [http://www.oracle.com/technetwork/server-storage/solaris10/downloads/index.html](http://www.oracle.com/technetwork/server-storage/solaris10/downloads/index.html)

The version tested is 1/13 (Oracle Solaris 10, x86).

To use a different version you should change the iso filename and the checksum.

## Setup

For most builders, you would need to have the corresponding guest tools already downloaded. To do this, you just need to manually select the creation of a machine from a given ISO and select the installation of the guest tools manually so that they get downloaded locally.

## Templates

Two different templates are provided:

* `template.json` : this is a quite complete installation of Solaris 10, with a full loaded GUI.

```
 packer build -var 'output_base=/Users/tnarik/Desktop/out2' template.json
```

* `reduced_template.json` : this is a reduced installation of Solaris 10, with a functional GUI.

```
 packer build -var 'output_base=/Users/tnarik/Desktop/out2' reduced_template.json
```

* `minimal_template.json` : this is a minimal installation of Solaris 10, without a GUI.

```
 packer build -var 'output_base=/Users/tnarik/Desktop/out2' minimal_template.json
```


## Fast testing

```
packer build -force -only=vagrant_virtualbox -var 'output_base=/Users/tnarik/Desktop/out2' template.json
```

## Caveats
### VMWare

When creating a vagrant box base on the VMware provider, the `pcislotnumber` needs to be forcefully set in the `Vagrantfile` to the same value used by the basebox, via:

```
vb.vmx["ethernet0.pcislotnumber"] = "33"
```

It looks like the Vagrant VMware Plugin uses a template to recreate the vmx file (or at least in some conditions), and this messes up with the interface names, resulting in a non-networked box.  