.PHONY: default
default: help

.PHONY: help
##@ Pattern tasks

# No need to add a comment here as help is described in common/
help:
	@make -f common/Makefile MAKEFILE_LIST="Makefile common/Makefile" help

%:
	make -f common/Makefile $*

.PHONY: generate-certs
generate-certs:  ## generate certificates and keys for httpbin demo application
	ansible-playbook "ansible/playbooks/generate-certs.yaml"
	@echo "Generated certs and keys"

.PHONY: install
install: operator-deploy post-install ## installs the pattern and loads the secrets
	@echo "Installed"

.PHONY: post-install
post-install: generate-certs load-secrets ## Post-install tasks
	@echo "Done"

.PHONY: test
test:
	@make -f common/Makefile PATTERN_OPTS="-f values-global.yaml -f values-hub.yaml" test
