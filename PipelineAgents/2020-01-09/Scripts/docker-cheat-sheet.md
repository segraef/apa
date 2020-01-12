# Docker Cheat Sheet
## Remove all images
```
docker system prune -a
docker rmi $(docker images -a -q)
```

## Remove all containers
```
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
```

