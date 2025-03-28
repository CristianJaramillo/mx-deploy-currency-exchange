#!/bin/bash

NAMESPACE="mx-bank"
DEPLOY_FILE="k8s/mysql-deployment.yaml"

echo "🔄 Eliminando recursos en el namespace $NAMESPACE..."
kubectl delete all --all -n $NAMESPACE --ignore-not-found
kubectl delete pvc --all -n $NAMESPACE --ignore-not-found
kubectl delete ingress --all -n $NAMESPACE --ignore-not-found
kubectl delete namespace $NAMESPACE --ignore-not-found

echo "⏳ Esperando que el namespace se elimine completamente..."
while kubectl get namespace $NAMESPACE >/dev/null 2>&1; do
  sleep 1
done

echo "✅ Namespace $NAMESPACE eliminado."

echo "🚀 Creando namespace $NAMESPACE..."
kubectl create namespace $NAMESPACE

kubectl create namespace $NAMESPACE

kubectl apply -f k8s/mx-bank-currency-exchange-rabbitmq-deployment.yaml
kubectl apply -f k8s/mx-bank-currency-exchange-rabbitmq-ingress.yaml

kubectl apply -f k8s/mx-bank-currency-exchange-mysql-deployment.yaml
kubectl apply -f k8s/mx-bank-currency-exchange-mysql-pv-claim.yaml
kubectl apply -f k8s/mx-bank-currency-exchange-mysql-service.yaml

kubectl apply -f k8s/mx-bank-ms-currency-exchange-configmap.yaml
kubectl apply -f k8s/mx-bank-ms-currency-exchange-deployment.yaml
kubectl apply -f k8s/mx-bank-ms-currency-exchange-service.yaml

kubectl apply -f k8s/mx-bank-wkr-currency-exchange-configmap.yaml
kubectl apply -f k8s/mx-bank-wkr-currency-exchange-deployment.yaml
# kubectl apply -f k8s/mx-bank-wkr-currency-exchange-service.yaml