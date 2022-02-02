docker build -t yp268/multi-client:latest -t yp268/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t yp268/multi-server:latest -t yp268/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t yp268/multi-worker:latets -t yp268/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yp268/multi-client:latest
docker push yp268/multi-server:latest
docker push yp268/multi-worker:latest

docker push yp268/multi-client:$SHA
docker push yp268/multi-server:$SHA
docker push yp268/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yp268/multi-server:$SHA
kubectl set image deployments/client-deployment client=yp268/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yp268/multi-worker:$SHA   