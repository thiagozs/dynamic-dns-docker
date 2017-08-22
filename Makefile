image:
	sudo docker build -t thiagozs/dyndns-server .

console:
	sudo docker run -it -p 8080:8080 -p 53:53 -p 53:53/udp --rm thiagozs/dyndns-server bash

server_test:
	sudo docker run -it -p 8080:8080 -p 53:53 -p 53:53/udp --env-file envfile --rm thiagozs/dyndns-server

api_test:
	curl "http://172.17.0.7:8080/update?secret=xpto&domain=amanda.dyndns&addr=192.168.0.33"
	dig @172.17.0.7 amanda.dyndns.thiagozs.com

api_test_recursion:
	dig @172.17.0.7 google.com

deploy: image
	sudo docker run -it -d -p 8080:8080 -p 172.18.1.17:53:53 -p 172.18.1.17:53:53/udp --env-file envfile --name=dyndns thiagozs/dyndns-server