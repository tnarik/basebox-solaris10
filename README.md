# Obtain the ISO image

You need to download this image manually as there is no automated way to do it.

You can find it from [http://www.oracle.com/technetwork/server-storage/solaris10/downloads/index.html](http://www.oracle.com/technetwork/server-storage/solaris10/downloads/index.html)

The version tested is 1/13 (Oracle Solaris 10, x86).

To use a different version you should change the iso filename and the checksum.

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
packer build -force -only=virtualbox-iso -var 'output_base=/Users/tnarik/Desktop/out2' template.json
```