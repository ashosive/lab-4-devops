# main.tf

# Define the required providers
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.0"
    }
  }
}

# Configure the Docker provider
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Define Docker container resource (example1)
resource "docker_container" "example1" {
  name    = "example-container"
  image   = "nginx:latest"
  ports {
    internal = 80
    external = 8086
  }
  restart = "always"
}

# Change infrastructure (Modify container name)
resource "docker_container" "example2" {
  name    = "updated-container"  # Change the container name
  image   = "nginx:latest"
  ports {
    internal = 80
    external = 8085
  }
  restart = "always"
}

# Create a plan
# No additional configuration needed, Terraform by default creates a plan
# Run `terraform plan` to generate and view the plan

# Apply the plan
# No additional configuration needed, Terraform by default applies the plan
# Run `terraform apply` to apply the plan

# Destroy the complete resource
# No additional configuration needed, Terraform by default destroys all resources
# Run `terraform destroy` to destroy all resources

# Create resource with dependencies (implicit and explicit)
# Here, we'll create two Docker containers where one depends on the other implicitly
resource "docker_container" "parent" {
  name    = "parent-container"
  image   = "ubuntu:latest"
  ports {
    internal = 80
    external = 8080
  }
  restart = "always"
}

resource "docker_container" "child" {
  name      = "child-container"
  image     = "nginx:latest"
  depends_on = [docker_container.parent]  # Explicit dependency on the parent container
  restart   = "always"
}
