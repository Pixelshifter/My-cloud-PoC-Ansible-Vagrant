# My own miniature cloud Proof of Concept
Easily deploy an VM environment with Vagrant, and provision servers with Ansible. All through a Bash script!

The Vagrant files can be changed of course, but the current environments are:

bronze
	- 1 load-balancer;
	- 2 web-servers;
	- 1 database-server.

silver
	- 1 load-balancer;
	- 3 web-servers;
	- 2 database-servers.
	
gold
  - 1 load-balancer;
	- 5 web-servers;
	- 2 database-servers.

The load balancer is HAproxy.
The web servers are equipped with nginx, php5-fpm & php5-mysql.
The database servers run mysql with depending on the environment, will be placed in a master-slave setup.



Usage:

Make sure the file 'run.sh' is executable.

The script accepts two arguments. Argument 1: 'bronze', 'silver' or 'gold'. Argument 2: 'deploy', 'update' or 'shutdown'

deploy initiates 'vagrant up' and runs a deploy_* playbook.

update initiates a rolling update for the web-servers (one at a time).

shutdown initiates 'vagrant suspend'.

