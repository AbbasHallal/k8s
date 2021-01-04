docker build -t abbas/multi-client:latest -t  abbas/multi-client:$SHA -f client/Dockerfile client/
docker build -t abbas/multi-server:latest -t abbas/multi-server:$SHA -f server/Dockerfile server/
docker build -t abbas/multi-workeri:lastest -t abbas/multi-worker:$SHA -f worker/Dockerfile worker/

docker push abbas/multi-client:latest
docker push abbas/multi-server:latest
docker push abbas/multi-workeri:lastest

docker push abbas/multi-client:$SHA
docker push abbas/multi-server:$SHA
docker push abbas/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=abbas/multi-server:$SHA
kubectl set image deployments/client-deployment client=abbas/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=abbas/multi-worker:$SHA


