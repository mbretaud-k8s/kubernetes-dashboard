#
# You need to define

all:

KEY = $(CURRENT_DIR)/secrets/ssl/tls.key
CERT = $(CURRENT_DIR)/secrets/ssl/tls.crt
POD_NAME=$(shell kubectl get pods --namespace=kubernetes-dashboard --output='json' | jq ".items | .[] | .metadata | select(.name | startswith(\"kubernetes-dashboard\")) | .name" | head -1 | sed 's/"//g')

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make deploy    - create resources from files"
	@echo "   2. make apply     - apply configurations to the resources"
	@echo "   3. make delete    - delete resources"
	@echo "   4. make describe  - show details of the resources"
	@echo "   5. make get       - display one or many resources"
	@echo "   6. make change	- change namespace"
	@echo ""

###############################################
#
# Deploy
#
###############################################
deploy:
	kubectl create -f kubernetes-dashboard-v2.0.0.yaml --save-config
	@sleep 1
	mkdir -p $(CURRENT_DIR)/secrets/ssl
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(KEY) -out $(CERT) -subj "/CN=nginxsvc/O=nginxsvc"
	@sleep 1
	kubectl create secret tls nginxsecret --namespace=kubernetes-dashboard --key $(KEY) --cert $(CERT) --save-config
	@sleep 1
	kubectl create -f kubernetes-dashboard-ingress.yaml --save-config

###############################################
#
# Apply
#
###############################################
apply:
	kubectl apply -f kubernetes-dashboard-v2.0.0.yaml
	kubectl apply -f kubernetes-dashboard-ingress.yaml

###############################################
#
# Delete
#
###############################################
delete:
	kubectl delete -f kubernetes-dashboard-ingress.yaml
	kubectl delete -f kubernetes-dashboard-v2.0.0.yaml

###############################################
#
# Describe
#
###############################################
describe:
	@echo "---------------------------"
	kubectl describe namespace/kubernetes-dashboard
	@echo ""
	kubectl describe serviceaccount/kubernetes-dashboard --namespace=kubernetes-dashboard
	@echo ""
	kubectl describe service/kubernetes-dashboard --namespace=kubernetes-dashboard
	@echo ""
	kubectl describe secret/kubernetes-dashboard-certs --namespace=kubernetes-dashboard
	@echo ""
	kubectl describe secret/kubernetes-dashboard-csrf --namespace=kubernetes-dashboard
	@echo ""
	kubectl describe secret/kubernetes-dashboard-key-holder --namespace=kubernetes-dashboard
	@echo ""
	kubectl describe configmap/kubernetes-dashboard-settings --namespace=kubernetes-dashboard
	@echo ""
	kubectl describe role.rbac.authorization.k8s.io/kubernetes-dashboard --namespace=kubernetes-dashboard
	@echo ""
	kubectl describe clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard --namespace=kubernetes-dashboard
	@echo ""
	kubectl describe rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard --namespace=kubernetes-dashboard
	@echo ""
	kubectl describe clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard --namespace=kubernetes-dashboard
	@echo ""
	kubectl describe deployment.apps/kubernetes-dashboard --namespace=kubernetes-dashboard
	@echo ""
	kubectl describe service/dashboard-metrics-scraper --namespace=kubernetes-dashboard
	@echo ""
	kubectl describe deployment.apps/dashboard-metrics-scraper --namespace=kubernetes-dashboard
	@echo ""
	kubectl describe ingress.networking.k8s.io/prometheus-ingress --namespace=kubernetes-dashboard
	@echo "---------------------------"

###############################################
#
# Get
#
###############################################
get:
	@echo "---------------------------"
	kubectl get namespace/kubernetes-dashboard --ignore-not-found
	@echo ""
	kubectl get serviceaccount/kubernetes-dashboard --namespace=kubernetes-dashboard --ignore-not-found
	@echo ""
	kubectl get service/kubernetes-dashboard --namespace=kubernetes-dashboard --ignore-not-found
	@echo ""
	kubectl get secret/kubernetes-dashboard-certs --namespace=kubernetes-dashboard --ignore-not-found
	@echo ""
	kubectl get secret/kubernetes-dashboard-csrf --namespace=kubernetes-dashboard --ignore-not-found
	@echo ""
	kubectl get secret/kubernetes-dashboard-key-holder --namespace=kubernetes-dashboard --ignore-not-found
	@echo ""
	kubectl get configmap/kubernetes-dashboard-settings --namespace=kubernetes-dashboard --ignore-not-found
	@echo ""
	kubectl get role.rbac.authorization.k8s.io/kubernetes-dashboard --namespace=kubernetes-dashboard --ignore-not-found
	@echo ""
	kubectl get clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard --namespace=kubernetes-dashboard --ignore-not-found
	@echo ""
	kubectl get rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard --namespace=kubernetes-dashboard --ignore-not-found
	@echo ""
	kubectl get clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard --namespace=kubernetes-dashboard --ignore-not-found
	@echo ""
	kubectl get deployment.apps/kubernetes-dashboard --namespace=kubernetes-dashboard --ignore-not-found
	@echo ""
	kubectl get service/dashboard-metrics-scraper --namespace=kubernetes-dashboard --ignore-not-found
	@echo ""
	kubectl get deployment.apps/dashboard-metrics-scraper --namespace=kubernetes-dashboard --ignore-not-found
	@echo ""
	kubectl get ingress.networking.k8s.io/prometheus-ingress --namespace=kubernetes-dashboard
	@echo "---------------------------"

###############################################
#
# Change Namespace
#
###############################################
change:
	kubectl config set-context $(shell kubectl config current-context) --namespace=kubernetes-dashboard

###############################################
#
# Get logs from the pod
#
###############################################
logs:
	kubectl logs pod/$(POD_NAME) --namespace=kubernetes-dashboard
