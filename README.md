tutum-docker-wordpress
======================

the image will be used for deploying dwordpress acroos the swarm with the help of version 3 compose.yml


Usage
-----

To create the image `tutum/wordpress`, execute the following command on the tutum-docker-wordpress folder:

	docker build -t tutum/wordpress .

You can now push your new image to the registry:

	docker push tutum/wordpress


Running your Wordpress docker image
-----------------------------------

Start your image:

	docker run -d -p 80:80 tutum/wordpress

Test your deployment:

	curl http://localhost/

You can now start configuring your Wordpress container!


More information
----------------

contact manish.mittal@ecs.co.uk
