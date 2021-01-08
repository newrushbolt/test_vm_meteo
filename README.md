
export YC_TOKEN=SECRET_YC_OAUTH_TOKEN

cd tf_yacloud && terraform init && terraform apply && export SERVER_IP="$(terraform output|grep ","|cut -d "\"" -f2)" && cd -

```
scp -r docker-compose/ ubuntu@$SERVER_IP:~/
ssh -t ubuntu@$SERVER_IP sudo -i
apt-get update && sleep 1 && apt-get -y install docker.io docker-compose git && systemctl enable docker --now
git clone git@github.com:newrushbolt/test_vm_meteo.git -b testing-yacloud
```

http://127.0.0.1/render/d/gDkRra-Gk/example-kp-meteo?orgId=1&width=1000&height=450&kiosk=tv&from=now-30m&to=now&var-location=Vodopad