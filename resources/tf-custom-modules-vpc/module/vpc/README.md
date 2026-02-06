to publish the terraform custom modules:

1. create a valid repository name on github - it should be public repository

- add MIT License (optional)
- add tags for the versioning

```base
git tag "v1.0.0"
git push --tags
```

2. go to [terraform registory - modules](https://registry.terraform.io/browse/modules), and sign in with github
3. Publish - choose the created github repo - Publish Modules
