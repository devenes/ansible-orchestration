#!/bin/bash

terraform init

terraform apply --auto-approve

sleep 10

echo "[application_servers]" > app_inventory.ini

terraform output | awk '{print $3}' >> app_inventory.ini

sleep 60

ansible-playbook playbook.yaml -i app_inventory.ini --extra-vars "script_filename=deneme.sh" --private-key=ssh1.pem
