GITPOD_NAMESPACE ?= gitpod
REG_PORT ?= 5000
MIRRORED_IMAGES = gitpod/workspace-base gitpod/workspace-full

REGISTRY_USER ?= username
REGISTRY_PASSWORD ?= password

DEPENDENCIES_NAME = dependencies

all: dependencies registry

dependencies:
	$(shell docker run --entrypoint htpasswd registry:2.7.0 -Bbn ${REGISTRY_USER} ${REGISTRY_PASSWORD} > /tmp/htpasswd)

	@helm dependencies update ./gitpod
	@helm upgrade \
		--atomic \
		--cleanup-on-fail \
		--create-namespace \
		--install \
		--namespace="${GITPOD_NAMESPACE}" \
		--reset-values \
		--set="registry.secrets.htpasswd=$$(cat /tmp/htpasswd)" \
		--wait \
		${DEPENDENCIES_NAME} \
		./gitpod

	@sleep 10
.PHONY: dependencies

kill_registry:
	@for reg in $$(ps -ef | awk '/kubectl/{print $$2}'); do \
		kill $$reg || true; \
	done
.PHONY: kill_registry

registry:
	$(MAKE) kill_registry || true

	@kubectl port-forward -n ${GITPOD_NAMESPACE} deployment/${DEPENDENCIES_NAME}-registry ${REG_PORT}:${REG_PORT} > /dev/null &

	@sleep 5

	@docker login \
		localhost:${REG_PORT} \
		-u ${REGISTRY_USER} \
		-p ${REGISTRY_PASSWORD}

	@for reg in ${MIRRORED_IMAGES}; do \
		echo "Mirroring $$reg to localhost:${REG_PORT}/$$reg"; \
		docker pull $$reg; \
		docker tag $$reg localhost:${REG_PORT}/$$reg; \
		docker push localhost:${REG_PORT}/$$reg; \
	done

	$(MAKE) kill_registry || true
.PHONY: registry
