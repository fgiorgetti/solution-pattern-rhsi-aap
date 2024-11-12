for i in cloud/net-a/*; do
    echo "cat << EOF > ${i}";
    cat "${i}"
    echo "EOF"
    echo
done
