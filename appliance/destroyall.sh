#turn on vagrants
for D in *; do
    if [[ -d "${D}" && -e "${D}/Vagrantfile" ]]; then
        cd "${D}"
        vagrant destroy -f
        cd ..
    fi
done
