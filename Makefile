# Makefile for aarch64-asm Docker Playground
# IMAGE_NAME: Name of the Docker image to build and run
IMAGE_NAME := aarch64-asm
# PLAYGROUND_NAME: Name of the Docker container instance
PLAYGROUND_NAME := arm64-playground

# SHARED_WS: Path to the shared workspace folder for Docker (use present directory)
SHARED_WS := $(CURDIR)/ws_shared_with_docker

# Build the Docker image with the specified IMAGE_NAME
build:        ## Build the Docker image with the specified IMAGE_NAME
	@echo "Building Docker image: $(IMAGE_NAME)"
	docker build -t $(IMAGE_NAME) .

# Start the Colima VM, ensure the Docker image exists, and run the container if not already running
start:        ## Start the Colima VM, ensure the Docker image exists, and run the container if not already running
	@echo "Checking if Colima VM is running..."
	@if [ "$$(colima status 2>/dev/null)" = "RUNNING" ]; then \
		echo "Colima is already running."; \
	else \
		echo "Starting Colima..."; \
		colima start; \
	fi
	@echo "Checking if Docker image '$(IMAGE_NAME)' exists or needs to be built..."
	$(MAKE) check-image
	$(MAKE) run-container

# Run the Docker container if not already running
run-container: ## Run or resume the Docker container
	@echo "Checking container '$(PLAYGROUND_NAME)' status..."
	@if docker ps --format '{{.Names}}' | grep -wq $(PLAYGROUND_NAME); then \
		echo "Container is already running. Attaching..."; \
		docker exec -it $(PLAYGROUND_NAME) /bin/bash || docker attach $(PLAYGROUND_NAME); \
	elif docker ps -a --format '{{.Names}}' | grep -wq $(PLAYGROUND_NAME); then \
		echo "Container exists but is stopped. Starting and attaching..."; \
		docker start -ai $(PLAYGROUND_NAME); \
	else \
		echo "Creating and running new container '$(PLAYGROUND_NAME)' from '$(IMAGE_NAME)'..."; \
		docker run -it \
			-v $(SHARED_WS):/work \
			--name $(PLAYGROUND_NAME) \
			$(IMAGE_NAME); \
	fi


# Check if the Docker image exists; build it if not
check-image:  ## Check if the Docker image exists; build it if not
	@if ! docker image inspect $(IMAGE_NAME) > /dev/null 2>&1; then \
		echo "Docker image '$(IMAGE_NAME)' not found. Building..."; \
		$(MAKE) build; \
	else \
		echo "Docker image '$(IMAGE_NAME)' already exists. Skipping build."; \
	fi


# Remove the running container
clean-docker: ## Remove the running container
	@echo "Removing Docker container '$(PLAYGROUND_NAME)' (if exists)..."
	docker rm -f $(PLAYGROUND_NAME) || true

# Delete the Colima VM
clean-colima: ## Delete the Colima VM
	@echo "Deleting Colima VM..."
	colima delete

# Clean both: remove container and delete Colima VM
clean:        ## Clean both: remove container and delete Colima VM
	clean-docker clean-colima

# Assemble and link aarch64 assembly files using cross tools
misc:         ## Assemble and link aarch64 assembly files using cross tools
	@echo "Assembling hello.s to hello.o..."
	aarch64-linux-gnu-as -o hello.o hello.s
	@echo "Linking hello.o to hello..."
	aarch64-linux-gnu-ld -o hello hello.o

.PHONY: help


# Show available make commands
help:         ## Show this help
	@echo "Available commands:"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## ' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@# Also list targets without descriptions:
	@grep -E '^[a-zA-Z0-9_-]+:' $(MAKEFILE_LIST) | grep -v '##' | \
	awk -F: '{printf "  \033[36m%-20s\033[0m\n", $$1}'

