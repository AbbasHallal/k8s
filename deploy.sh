docker build -t absh12/multi-client:latest -t  absh12/multi-client:$SHA -f client/Dockerfile client/
docker build -t absh12/multi-server:latest -t absh12/multi-server:$SHA -f server/Dockerfile server/
docker build -t absh12/multi-workeri:lastest -t absh12/multi-worker:$SHA -f worker/Dockerfile worker/

docker push absh12/multi-client:latest
docker push absh12/multi-server:latest
docker push absh12/multi-workeri:lastest

docker push absh12/multi-client:$SHA
docker push absh12/multi-server:$SHA
docker push absh12/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=absh12/multi-server:$SHA
kubectl set image deployments/client-deployment client=absh12/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=absh12/multi-worker:$SHA


