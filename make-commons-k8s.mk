#
# You need to define
#   dashboardFile
#   namespaceName

POD_NAME=$(shell kubectl get pods --output='json' | jq ".items | .[] | .metadata | select(.name | startswith(\"$(deploymentName)\")) | .name" | head -1 | sed 's/"//g')

all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make deploy    - create resources from files"
	@echo "   2. make apply     - apply configurations to the resources"
	@echo "   3. make delete    - delete resources"
	@echo "   4. make describe  - show details of the resources"
	@echo "   5. make get       - display one or many resources"
	@echo ""

###############################################
#
# Deploy
#
###############################################
deploy:
	kubectl create -f $(dashboardFile) --save-config

###############################################
#
# Apply
#
###############################################
apply:
	kubectl apply -f $(dashboardFile)

###############################################
#
# Delete
#
###############################################
delete:
	kubectl delete -f $(dashboardFile)

###############################################
#
# Describe
#
###############################################
describe:
	@echo "---------------------------"
	kubectl describe namespace/$(namespaceName)
	@echo ""
	kubectl describe serviceaccount/kubernetes-dashboard --namespace=$(namespaceName)
	@echo ""
	kubectl describe service/kubernetes-dashboard --namespace=$(namespaceName)
	@echo ""
	kubectl describe secret/kubernetes-dashboard-certs --namespace=$(namespaceName)
	@echo ""
	kubectl describe secret/kubernetes-dashboard-csrf --namespace=$(namespaceName)
	@echo ""
	kubectl describe secret/kubernetes-dashboard-key-holder --namespace=$(namespaceName)
	@echo ""
	kubectl describe configmap/kubernetes-dashboard-settings --namespace=$(namespaceName)
	@echo ""
	kubectl describe role.rbac.authorization.k8s.io/kubernetes-dashboard --namespace=$(namespaceName)
	@echo ""
	kubectl describe clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard --namespace=$(namespaceName)
	@echo ""
	kubectl describe rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard --namespace=$(namespaceName)
	@echo ""
	kubectl describe clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard --namespace=$(namespaceName)
	@echo ""
	kubectl describe deployment.apps/kubernetes-dashboard --namespace=$(namespaceName)
	@echo ""
	kubectl describe service/dashboard-metrics-scraper --namespace=$(namespaceName)
	@echo ""
	kubectl describe deployment.apps/dashboard-metrics-scraper --namespace=$(namespaceName)
	@echo "---------------------------"

###############################################
#
# Get
#
###############################################
get:
	@echo "---------------------------"
	kubectl get namespace/$(namespaceName)
	@echo ""
	kubectl get serviceaccount/kubernetes-dashboard --namespace=$(namespaceName)
	@echo ""
	kubectl get service/kubernetes-dashboard --namespace=$(namespaceName)
	@echo ""
	kubectl get secret/kubernetes-dashboard-certs --namespace=$(namespaceName)
	@echo ""
	kubectl get secret/kubernetes-dashboard-csrf --namespace=$(namespaceName)
	@echo ""
	kubectl get secret/kubernetes-dashboard-key-holder --namespace=$(namespaceName)
	@echo ""
	kubectl get configmap/kubernetes-dashboard-settings --namespace=$(namespaceName)
	@echo ""
	kubectl get role.rbac.authorization.k8s.io/kubernetes-dashboard --namespace=$(namespaceName)
	@echo ""
	kubectl get clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard --namespace=$(namespaceName)
	@echo ""
	kubectl get rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard --namespace=$(namespaceName)
	@echo ""
	kubectl get clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard --namespace=$(namespaceName)
	@echo ""
	kubectl get deployment.apps/kubernetes-dashboard --namespace=$(namespaceName)
	@echo ""
	kubectl get service/dashboard-metrics-scraper --namespace=$(namespaceName)
	@echo ""
	kubectl get deployment.apps/dashboard-metrics-scraper --namespace=$(namespaceName)
	@echo "---------------------------"
