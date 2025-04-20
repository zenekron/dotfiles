@default:
	just --list

ansible-apply:
	ansible-playbook --ask-become-pass -i ./ansible/inventory.yaml ./ansible/site.yaml

ansible-diff:
	ansible-playbook --ask-become-pass -i ./ansible/inventory.yaml ./ansible/site.yaml --check --diff

ansible-dump:
	ansible -i ./ansible/inventory.yaml -m ansible.builtin.setup control
