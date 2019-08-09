# kubectl and helm
For GitLab CI/DC

```bash
docker build -t helm:ci .
docker push  helm:ci
```
Example 
```yaml
stages:
  - deploy
deploy:
  stage: deploy
  image: helm:ci
  variables:
    K8S_API_URL: none
    K8S_TOKEN: none
    K8S_CI_NAMESPACE: none
  before_script:
    - kubectl config set-cluster k8s --insecure-skip-tls-verify=true --server=$K8S_API_URL
    - kubectl config set-credentials ci --token=$K8S_TOKEN
    - kubectl config set-context ci --cluster=k8s --user=ci --namespace=$K8S_CI_NAMESPACE
    - kubectl config use-context ci
    - helm init --client-only
  script:
    - helm upgrade --install myservice .helm
        --debug
        --recreate-pods
        --tiller-namespace=$K8S_CI_NAMESPACE
```
