OUTPUT="/Users/tnarik/Desktop/out2"
packer build -force -only=virtualbox,vmware -var "output_base=${OUTPUT}" minimal_template.json
packer build -force -only=parallels -var "output_base=${OUTPUT}" minimal_template.json
packer build -force -only=virtualbox,vmware -var "output_base=${OUTPUT}" template.json
packer build -force -only=parallels -var "output_base=${OUTPUT}" template.json
mkdir -p /Users/tnarik/Desktop/out2/solaris10/.
cp metadata/metadata.json /Users/tnarik/Desktop/out2/solaris10/.
mkdir -p /Users/tnarik/Desktop/out2/solaris10-minimal/.
cp metadata-minimal/metadata.json /Users/tnarik/Desktop/out2/solaris10-minimal/.
