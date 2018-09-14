build:
	cd 1.10.0 && docker build -t messari/dogecoin-core:1.10.0 .
	docker tag messari/dogecoin-core:1.10.0 messari/dogecoin-core:latest

push:
	docker push messari/dogecoin-core:1.10.0
	docker push messari/dogecoin-core:latest
