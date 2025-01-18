start:
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