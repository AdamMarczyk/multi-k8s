docker build -t adammarczyk/multi-client:latest -t adammarczyk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t adammarczyk/multi-server:latest -t adammarczyk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t adammarczyk/multi-worker:latest -t adammarczyk/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push adammarczyk/multi-client:latest
docker push adammarczyk/multi-server:latest
docker push adammarczyk/multi-worker:latest

docker push adammarczyk/multi-client:$SHA
docker push adammarczyk/multi-server:$SHA
docker push adammarczyk/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=adammarczyk/multi-server:$SHA
kubectl set image deployments/client-deployment client=adammarczyk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=adammarczyk/multi-worker:$SHA
