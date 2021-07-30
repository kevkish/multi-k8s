docker build -t kevkish/multi-client:latest -t kevkish/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kevkish/multi-server:latest -t kevkish/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kevkish/multi-worker:latest -t kevkish/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kevkish/multi-client:latest
docker push kevkish/multi-server:latest
docker push kevkish/multi-worker:latest

docker push kevkish/multi-client:$SHA
docker push kevkish/multi-server:$SHA
docker push kevkish/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=kevkish/multi-client:$SHA
kubectl set image deployments/server-deployment server=kevkish/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=kevkish/multi-worker:$SHA