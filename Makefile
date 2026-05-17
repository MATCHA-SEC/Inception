create_volumes:
	mkdir -p /home/shadria-/data/DataBase
	mkdir -p /home/shadria-/data/WordPress

all : up

up :
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker-compose -f ./srcs/docker-compose.yml down

rm_volumes:
	@docker volume rm $(shell docker volume ls -q)

rm_img:
	@docker system prune -af --volumes

cleanData:
	@rm -rf /home/shadria-/data/WordPress/*
	@rm -rf /home/shadria-/data/DataBase/*
	chmod 777 /home/shadria-/data/*


fclean : down rm_img rm_volumes cleanData