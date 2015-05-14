OUTPUT="${HOME}/Desktop/output"
DISTRO="full" # full / reduced / minimal
UPDATE="u8" # u8 / u11
packer build -force -only=virtualbox,vmware -var-file=${UPDATE}.json -var "output_base=${OUTPUT}" -var "distro=${DISTRO}" template.json
packer build -force -only=parallels -var-file=${UPDATE}.json -var "output_base=${OUTPUT}" -var "distro=${DISTRO}" template.json

mkdir -p ${OUTPUT}/solaris10-${UPDATE}-${DISTRO}/.
UPDATE="${UPDATE}" DISTRO="${DISTRO}" erb metadata/metadata.json.erb > ${OUTPUT}/solaris10-${UPDATE}-${DISTRO}/metadata.json
