listing workspaces

```base
terraform workspace list
```

creating a workspaces

```base
terraform workspace new <workspace_name>
```

selecting a workspaces

```base
terraform workspace select <workspace_name>
```

showing a current workspaces

```base
terraform workspace show
```

Deleting a workspaces

```base
terraform workspace select default   # after the deletion default workspace would be active
terraform workspace delete <workspace_name>
```
