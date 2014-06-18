#turn on vagrants
for D in *; do
    if [[ -d "${D}" && -e "${D}/Vagrantfile" ]]; then
        cd "${D}"
        vagrant up
        cd ..
    fi
done