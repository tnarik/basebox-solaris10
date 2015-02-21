OUTPUT="${HOME}/Desktop/output"
packer build -force -only=virtualbox,vmware -var "output_base=${OUTPUT}" minimal_template.json
packer build -force -only=parallels -var "output_base=${OUTPUT}" minimal_template.json
packer build -force -only=virtualbox,vmware -var "output_base=${OUTPUT}" template.json
packer build -force -only=parallels -var "output_base=${OUTPUT}" template.json
mkdir -p ${OUTPUT}/solaris10/.
cp metadata/metadata.json ${OUTPUT}/solaris10/.
mkdir -p ${OUTPUT}/solaris10-minimal/.
cp metadata-minimal/metadata.json ${OUTPUT}/solaris10-minimal/.
