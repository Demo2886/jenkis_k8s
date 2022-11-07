# DevOps test assignment for IT Bootcamp participants!

## For testing and quick setup of the K8s environment, I chose KIND.
Repository links >> [KIND](https://github.com/kubernetes-sigs/kind)!!!




## These command will copy the kubeconfig to the jenkins user root directory. After that re-run jenkins pipeline.

```bash
sudo cp ~/.kube/config ~jenkins/.kube/
sudo chown -R jenkins: ~jenkins/.kube/
```


## Final image
![Image](./pic_pipline.png)
![Image](./pic_slack.png)
![Image](./pic_dockerHub.png)

