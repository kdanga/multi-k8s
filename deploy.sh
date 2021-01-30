# Build Images
docker build -t kdanga/multi-client:latest -t kdanga/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kdanga/multi-server:latest -t kdanga/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kdanga/multi-worker:latest -t kdanga/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Push Images to Docker Hub
docker push kdanga/multi-client:latest
docker push kdanga/multi-server:latest
docker push kdanga/multi-worker:latest
docker push kdanga/multi-client:$SHA
docker push kdanga/multi-server:$SHA
docker push kdanga/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=kdanga/multi-client:$SHA
kubectl set image deployments/server-deployment server=kdanga/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=kdanga/multi-worker:$SHA
