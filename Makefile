start: start-cluster save-kubeconfig

start-cluster:
	terraform init
	terraform plan -var-file="env.tfvars"
	terraform apply -var-file="env.tfvars"

clean:
	terraform destroy -var-file=env.tfvars
	doctl auth init
	@for id in $(shell doctl compute droplet list --format ID --no-header); do \
		echo "Deleting droplet $$id"; \
		doctl compute droplet delete $$id --force; \
	done

# Command to get the cluster ID
CLUSTER_ID := $(shell doctl kubernetes cluster list --format Name,ID | grep k8s-cluster | awk '{print $$2}')

save-kubeconfig:
	@echo "Saving kubeconfig for cluster ID $(CLUSTER_ID)..."
	doctl kubernetes cluster kubeconfig save $(CLUSTER_ID)
	@echo "Kubeconfig saved."