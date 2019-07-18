docker build -t udioz/multi-client:latest -t udioz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t udioz/multi-server:latest -t udioz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t udioz/multi-worker:latest -t udioz/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push udioz/multi-client:latest
docker push udioz/multi-server:latest
docker push udioz/multi-worker:latest

docker push udioz/multi-client:$SHA
docker push udioz/multi-server:$SHA
docker push udioz/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=udioz/multi-client:$SHA
kubectl set image deployments/server-deployment server=udioz/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=udioz/multi-worker:$SHA