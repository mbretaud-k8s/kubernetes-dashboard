CURRENT_DIR = $(shell pwd)

# Dashboard
dashboardFile=kubernetes-dashboard-v2.0.0.yaml

# Namespace
namespaceName=kubernetes-dashboard

$(info ############################################### )
$(info # )
$(info # Environment variables )
$(info # )
$(info ############################################### )
$(info CURRENT_DIR: $(CURRENT_DIR))

$(info )
$(info ############################################### )
$(info # )
$(info # Parameters )
$(info # )
$(info ############################################### )
$(info dashboardFile: $(dashboardFile))
$(info namespaceName: $(namespaceName))
$(info )

include $(CURRENT_DIR)/make-commons-k8s.mk
