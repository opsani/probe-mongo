REPO      = opsani
IMAGE_TAG = latest
PROBE     = mongo

.PHONY: all \
        push

all:
	docker build --no-cache --pull -t ${REPO}/probe-${PROBE}:${IMAGE_TAG} .

push:
	docker push ${REPO}/probe-${PROBE}:${IMAGE_TAG}
