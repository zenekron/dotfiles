@default:
	just --list

ansible-apply:
	ansible-playbook -i ./ansible/inventory.yaml ./ansible/playbook.yaml

ansible-diff:
	ansible-playbook -i ./ansible/inventory.yaml ./ansible/playbook.yaml --check --diff
