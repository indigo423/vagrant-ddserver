vagrant-ddserver
================

Vagrant environment for the ddserver project.

ddserver is a server-side application for dynamic DNS management.

It allows you to specify hostnames (subdomains) inside a dynamic DNS zone, and to update the IP address of those hostnames using a dynamic update protocol (no-ip protocol). This enables you to access hosts with dynamic IP addresses by a static domain name, even if the IP address changes. As updates of the IP address are performed using the no-ip update protocol, most DSL home-routers are able to send updates of the IP address. Also, there is a tool called ddclient, which can be used to send updates from any *NIX-based OS.

ddserver is written in Python and comes in three parts:

* ddserver-bundle is the bundled version of
  * ddserver-interface: A nice-looking webinterface for adding hostnames, administrating dynamic zones and managing users
  * ddserver-updater: The implementation of the no-ip update protocol
* ddserver-recursor is the application that answers DNS queries. It runs as a pipe-backend for the PowerDNS server.

All the web-stuff is using the Bottle web-framework using clean HTML5 and the Bootstrap CSS framework.

The project page: https://ddserver.0x80.io/
