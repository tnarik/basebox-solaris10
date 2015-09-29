OUTPUT="${HOME}/Desktop/output"
UPDATE="u8" # u8 / u11
DISTRO="full" # full / reduced / minimal

DISTRO="full"
packer build -force -only=vmware -var-file=${UPDATE}.json -var "output_base=${OUTPUT}" -var "distro=${DISTRO}" template.json
mkdir -p ${OUTPUT}/solaris10-${UPDATE}-${DISTRO}/.
UPDATE="u8" DISTRO="full" erb metadata/metadata.json.erb > ${OUTPUT}/solaris10-${UPDATE}-${DISTRO}/metadata.json

DISTRO="minimal"
packer build -force -only=vmware -var-file=${UPDATE}.json -var "output_base=${OUTPUT}" -var "distro=${DISTRO}" template.json
mkdir -p ${OUTPUT}/solaris10-${UPDATE}-${DISTRO}/.
UPDATE="u8" DISTRO="minimal" erb metadata/metadata.json.erb > ${OUTPUT}/solaris10-${UPDATE}-${DISTRO}/metadata.json

UPDATE="u9"
DISTRO="full"
packer build -force -only=vmware -var-file=${UPDATE}.json -var "output_base=${OUTPUT}" -var "distro=${DISTRO}" template.json
mkdir -p ${OUTPUT}/solaris10-${UPDATE}-${DISTRO}/.
UPDATE="u9" DISTRO="full" erb metadata/metadata.json.erb > ${OUTPUT}/solaris10-${UPDATE}-${DISTRO}/metadata.json

DISTRO="minimal"
packer build -force -only=vmware -var-file=${UPDATE}.json -var "output_base=${OUTPUT}" -var "distro=${DISTRO}" template.json
mkdir -p ${OUTPUT}/solaris10-${UPDATE}-${DISTRO}/.
UPDATE="u9" DISTRO="minimal" erb metadata/metadata.json.erb > ${OUTPUT}/solaris10-${UPDATE}-${DISTRO}/metadata.json


UPDATE="u11"
DISTRO="full"
packer build -force -only=vmware -var-file=${UPDATE}.json -var "output_base=${OUTPUT}" -var "distro=${DISTRO}" template.json
mkdir -p ${OUTPUT}/solaris10-${UPDATE}-${DISTRO}/.
UPDATE="u11" DISTRO="full" erb metadata/metadata.json.erb > ${OUTPUT}/solaris10-${UPDATE}-${DISTRO}/metadata.json

DISTRO="minimal"
packer build -force -only=vmware -var-file=${UPDATE}.json -var "output_base=${OUTPUT}" -var "distro=${DISTRO}" template.json
mkdir -p ${OUTPUT}/solaris10-${UPDATE}-${DISTRO}/.
UPDATE="u11" DISTRO="minimal" erb metadata/metadata.json.erb > ${OUTPUT}/solaris10-${UPDATE}-${DISTRO}/metadata.json
