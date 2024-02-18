### Usage

- Make sure the variables defined in $ROLE/vars/main.yml are correct

Run it:

```bash
ansible-playbook -u root -i inventory.ini workstation.yml
ansible-playbook -u root -i inventory.ini nfs-server.yml
```

Maintenance:

```bash
# Package management tasks
# Available tags:
#  update
#  add_pkg (needs --extra-vars "pkg=Package name")
#  del_pkg (needs --extra-vars "pkg=Package name")
# Example:
ansible-playbook maintenance.yml -u root -t add_pkg --extra-vars "pkg=git" -i inventory.ini
ansible-playbook maintenance.yml -u root -t del_pkg --extra-vars "pkg=git" -i inventory.ini
ansible-playbook maintenance.yml -u root -t update -i inventory.ini
```
