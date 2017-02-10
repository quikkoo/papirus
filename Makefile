SHELL = /bin/sh

IMAGE = $(USER)/papirus-$(OS):osp
DOKERFILE = dockerfile-$(OS)
CONTAINER = papirus-os


all: setup test

setup: dockerfile-$(OS)
	docker build -f dockerfile-$(OS) -t $(IMAGE) --pull .

create:
	docker create -it --name $(CONTAINER) $(IMAGE)
	docker start $(CONTAINER)

remove:
	docker stop $(CONTAINER)
	docker rm $(CONTAINER)

test-suite:
	@echo "run tests on $(OS)"
	bats .

test: *.bats create test-suite remove

clean:
	docker rmi $(IMAGE)
