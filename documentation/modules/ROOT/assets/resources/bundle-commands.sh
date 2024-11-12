TARGET_DIR='internal/net-a'
echo "mkdir -p ${TARGET_DIR}"
echo

for i in internal/net-a/*; do
    filename=$(basename "${i}")
    echo "cat << EOF > ${TARGET_DIR}/${filename}";
    cat "${i}"
    echo "EOF"
    echo
done

cat << EOF
kubectl -n net-a get accessgrant net-a-grant -o template --template '
apiVersion: skupper.io/v2alpha1
kind: AccessToken
metadata:
  name: net-a-token
spec:
  code: "{{ .status.code }}"
  ca: {{ printf "%q" .status.ca }}
  url: "{{ .status.url }}"
' > ${TARGET_DIR}/30-accesstoken.yaml
EOF
