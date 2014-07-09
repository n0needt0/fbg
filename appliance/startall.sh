#turn on vagrants
for D in *; do
    if [[ -d "${D}" && -e "${D}/Vagrantfile" ]]; then
        cd "${D}"
        echo "Installing ${D} virtual machine..."
        sleep 1
        vagrant up
        cd ..
    fi
done