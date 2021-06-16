docker build -t jeyfarmer/multi-client:latest -t jeyfarmer/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jeyfarmer/multi-server:latest -t jeyfarmer/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jeyfarmer/multi-worker:latest -t jeyfarmer/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jeyfarmer/multi-client:latest
docker push jeyfarmer/multi-client:$SHA
docker push jeyfarmer/multi-server:latest
docker push jeyfarmer/multi-server:$SHA
docker push jeyfarmer/multi-worker:latest
docker push jeyfarmer/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jeyfarmer/multi-server:$SHA
kubectl set image deployments/client-deployment client=jeyfarmer/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jeyfarmer/multi-worker:$SHA