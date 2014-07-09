#turn on vagrants
for D in *; do
    if [[ -d "${D}" && -e "${D}/Vagrantfile" ]]; then
        cd "${D}"
        echo "Halting ${D} virtual machine..."
        sleep 1
        vagrant suspend
        cd ..
    fi
done