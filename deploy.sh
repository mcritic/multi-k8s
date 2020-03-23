docker build -t mcritic/multi-client:latest -t mcritic/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mcritic/multi-server:latest -t mcritic/multi-server:$SHA -f ./server/Dockerfile ./server
doceer build -t mcritic/multi-worker:latest -t mcritic/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mcritic/multi-client:latest
docker push mcritic/multi-server:latest
docker push mcritic/multi-worker:latest

docker push mcritic/multi-client:$SHA
docker push mcritic/multi-server:$SHA
docker push mcritic/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mcritic/multi-server:$SHA
kubectl set image deployments/client-deployment client=mcritic/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mcritic/multi-worker:$SHA