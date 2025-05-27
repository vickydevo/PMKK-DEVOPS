# Writing your first Helm3 Chart for "Hello World"

Now after you have done your Helm3 Chart installation, we can write our first "Hello World" Helm3 Chart.

To begin with -

---

## 2.1: Create your first Helm3 Chart

We are going to create our first helloworld Helm3 Chart using the following command:

```bash
helm3 create helloworld
```

It should create a directory `helloworld`, you can verify it by using the following command:

```bash
ls -lart | grep helloworld
```

It should return you with:

```bash
drwxr-xr-x 4 vagrant vagrant     4096 Nov  7 19:57 helloworld
```

To verify the complete directory structure of the Helm3 Chart, run:

```bash
tree helloworld
```

Expected output:

```
helloworld
├── charts
├── Chart.yaml
├── templates
│  ├── deployment.yaml
│  ├── _helpers.tpl
│  ├── hpa.yaml
│  ├── ingress.yaml
│  ├── NOTES.txt
│  ├── serviceaccount.yaml
│  ├── service.yaml
│  └── tests
│      └── test-connection.yaml
└── values.yaml
```

Great, now you created your first Helm3 Chart - `helloworld`.

---

## 2.2: Update the service.type from ClusterIP to NodePort inside the values.yaml

Before you run your helloworld Helm3 Chart, update the `service.type` from `ClusterIP` to `NodePort`.

The reason for this change is: After installing/running the helloworld Helm3 Chart, you should be able to access the service outside of the Kubernetes cluster. If you do not change the `service.type`, you will only be able to access the service within the Kubernetes cluster.

First, go inside the directory `helloworld`:

```bash
cd helloworld
```

### 2.2.1: Open values.yaml in vi

Open the `values.yaml` in `vi`:

```bash
vi values.yaml
```

### 2.2.2: Update service.type from ClusterIP to NodePort

Look for the `service.type` block and update its value to `NodePort`:

```yaml
service:
    type: NodePort
    port: 80
```

---

## 2.3: Install the Helm3 Chart using command - helm3 install

Now after updating the `values.yaml`, you can install the Helm3 Chart.

**Note:** The `helm3 install` command takes two arguments:

- First argument: Release name that you pick
- Second argument: Chart you want to install

It should look like:

```bash
helm3 install <RELEASE_NAME> <CHART_NAME>
```

Your final command would be:

```bash
microk8s config > ~/.kube/config
helm3 install myhelloworld helloworld 
or 
microk8s helm3 install myhelloworld helloworld

```

After running the above command, it should return you with:

```
NAME: myhelloworld
LAST DEPLOYED: Sat Nov  7 21:48:08 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
    export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services myhelloworld-helloworld)
    export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")
    echo http://$NODE_IP:$NODE_PORT
```

---

## 2.4: Verify the helm3 install command

Now verify your helm3 release (`myhelloworld`) by running:

```bash
microk8s helm3 list -a
```

It should return you with the release name you have just installed:

```
NAME           NAMESPACE  REVISION  UPDATED                               STATUS    CHART            APP VERSION
myhelloworld   default    1         2020-11-07 21:48:08.8550677 +0000 UTC deployed  helloworld-0.1.0 1.16.0
```

---

## 2.5: Get Kubernetes Service details and port

Run the following command to get the NodePort:

```bash
kubectl get service
```

Expected output:

```
NAME                     TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
kubernetes               ClusterIP   10.233.0.1      <none>        443/TCP        14d
myhelloworld-helloworld  NodePort    10.233.14.134   <none>        80:30738/TCP   7m10s
```

**Note:** The NodePort number can vary in the range 30000-32767, so you might get a different NodePort.

Since the cluster IP is `100.0.0.2` and NodePort is `30738`, you can access your Nginx page of your `myhelloworld` Helm3 Chart.

---

**Helm3 chart: helloworld**