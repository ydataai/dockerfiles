import os

from tornado.httpclient import AsyncHTTPClient
from kubernetes import client

# Configure JupyterHub to use the curl backend for making HTTP requests,
# rather than the pure-python implementations. The default one starts
# being too slow to make a large number of requests to the proxy API
# at the rate required.
AsyncHTTPClient.configure("tornado.curl_httpclient.CurlAsyncHTTPClient")

#------------------------------------------------------------------------------
# Application(SingletonConfigurable) configuration
#------------------------------------------------------------------------------

## This is an application.

## The date format used by logging formatters for %(asctime)s
#c.Application.log_datefmt = '%Y-%m-%d %H:%M:%S'

## The Logging format template
#c.Application.log_format = '[%(name)s]%(highlevel)s %(message)s'

## Set the log level by value or name.
# Options: (0, 10, 20, 30, 40, 50, 'DEBUG', 'INFO', 'WARN', 'ERROR', 'CRITICAL')
c.Application.log_level = 0

#------------------------------------------------------------------------------
# JupyterHub(Application) configuration
#------------------------------------------------------------------------------

## Resolution (in seconds) for updating activity
#
#  If activity is registered that is less than activity_resolution seconds more
#  recent than the current value, the new value will be ignored.
#
#  This avoids too many writes to the Hub database.
# c.JupyterHub.activity_resolution = 30

## Grant admin users permission to access single-user servers.
c.JupyterHub.admin_access = True

## Set of users that will have admin rights on this JupyterHub.
c.Authenticator.admin_users = set('root')

## Class for authenticating users
c.JupyterHub.authenticator_class = 'dummyauthenticator.DummyAuthenticator'

#------------------------------------------------------------------------------
# ConfigurableHTTPProxy configuration
#------------------------------------------------------------------------------

# Connect to a proxy running in a different pod
api_ip = os.environ['PROXY_API_SERVICE_HOST']
api_port = int(os.environ['PROXY_API_SERVICE_PORT'])
c.ConfigurableHTTPProxy.api_url = 'http://{}:{}'.format(api_ip, api_port)
c.ConfigurableHTTPProxy.should_start = False

## Public IP
public_ip = os.environ['PROXY_PUBLIC_SERVICE_HOST']
public_port = int(os.environ['PROXY_PUBLIC_SERVICE_PORT'])
c.JupyterHub.bind_url = 'http://{}:{}'.format(public_ip, public_port)

# Gives spawned containers access to the API of the hub
hub_connect_ip = os.environ['HUB_SERVICE_HOST']
hub_connect_port = int(os.environ['HUB_SERVICE_PORT'])
c.JupyterHub.hub_connect_ip = hub_connect_ip
c.JupyterHub.hub_connect_url = 'http://{}:{}'.format(hub_connect_ip, hub_connect_port)

c.JupyterHub.hub_ip = '0.0.0.0'

# Do not shut down user pods when hub is restarted
c.JupyterHub.cleanup_servers = False

# TODO: add this
## url for the database. e.g. `sqlite:///jupyterhub.sqlite`
c.JupyterHub.db_url = 'sqlite:///jupyterhub.sqlite'

# Check that the proxy has routes appropriately setup
c.JupyterHub.last_activity_interval = 60

## The class to use for configuring the JupyterHub proxy.
# c.JupyterHub.proxy_class = 'jupyterhub.proxy.ConfigurableHTTPProxy'

## The class to use for spawning single-user servers.
c.JupyterHub.spawner_class = 'kubespawner.KubeSpawner'

## Extra settings overrides to pass to the tornado application.
# Don't wait at all before redirecting a spawning user to the progress page
c.JupyterHub.tornado_settings = {
    'slow_spawn_timeout': 0,
}

#------------------------------------------------------------------------------
# KubeSpawner configuration
#------------------------------------------------------------------------------

# c.KubeSpawner.cmd = 'jupyterhub-singleuser'

c.KubeSpawner.namespace = os.environ.get('POD_NAMESPACE', 'default')

c.KubeSpawner.image = 'ydata/jupyterlab:0.0.4'

## Storage Settings
pvc_name_template = 'claim-{username}{servername}'
volume_name_template = 'volume-{username}{servername}'

c.KubeSpawner.pvc_name_template = pvc_name_template
c.KubeSpawner.storage_pvc_ensure = True
c.KubeSpawner.storage_access_modes = ['ReadWriteOnce']
c.KubeSpawner.storage_capacity = '10Gi'

# Add volumes to singleuser pods
c.KubeSpawner.volumes = [{
    'name': volume_name_template,
    'persistentVolumeClaim': {
        'claimName': pvc_name_template
    }
}]

c.KubeSpawner.volume_mounts = [{
    'mountPath': '/home/jovyan',
    'name': volume_name_template
}]

# c.Spawner.cmd = 'jupyterhub-singleuser --ip=0.0.0.0'
c.Spawner.debug = True

#------------------------------------------------------------------------------
# GKE configuration
#------------------------------------------------------------------------------

# add dedicated-node toleration
for key in (
    'hub.jupyter.org/dedicated',
    # workaround GKE not supporting / in initial node taints
    'hub.jupyter.org_dedicated',
):
    c.KubeSpawner.tolerations.append(
        dict(
            key=key,
            operator='Equal',
            value='user',
            effect='NoSchedule',
        )
    )

# Enable cull
cull_cmd = [
    '/usr/local/bin/cull_idle_servers.py',
]
base_url = c.JupyterHub.get('base_url', '/')
cull_cmd.append(
    '--url=http://127.0.0.1:8081' + base_url + 'hub/api'
)

cull_timeout = 3600
if cull_timeout:
    cull_cmd.append('--timeout=%s' % cull_timeout)

cull_every = 600
if cull_every:
    cull_cmd.append('--cull-every=%s' % cull_every)

cull_concurrency = 10
if cull_concurrency:
    cull_cmd.append('--concurrency=%s' % cull_concurrency)

cull_max_age = 0
if cull_max_age:
    cull_cmd.append('--max-age=%s' % cull_max_age)

c.JupyterHub.services.append({
    'name': 'cull-idle',
    'admin': True,
    'command': cull_cmd,
})

network_tools_image = 'jupyterhub/k8s-network-tools:0.8.2'
ip_block_container = client.V1Container(
    name="block-cloud-metadata",
    image=network_tools_image,
    command=[
        'iptables',
        '-A', 'OUTPUT',
        '-d', '169.254.169.254',
        '-j', 'DROP'
    ],
    security_context=client.V1SecurityContext(
        privileged=True,
        run_as_user=0,
        capabilities=client.V1Capabilities(add=['NET_ADMIN'])
    )
)

c.KubeSpawner.init_containers.append(ip_block_container)