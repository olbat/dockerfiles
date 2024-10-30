# CUPS print server image

## Overview
Docker image including CUPS print server and printing drivers (installed from the Debian packages).

## Run the Cups server
Using the default [cupsd.conf](cupsd.conf) configuration file:
```bash
docker run -d -p 631:631 -v /var/run/dbus:/var/run/dbus --name cupsd olbat/cupsd
```

Using a custom cupsd.conf configuration file:
```bash
docker run -d -p 631:631 -v /var/run/dbus:/var/run/dbus -v $PWD/cupsd.conf:/etc/cups/cupsd.conf --name cupsd olbat/cupsd`
```

__Note__: the following mount can be added to configure a printer connected through USB `-v /dev/bus/usb:/dev/bus/usb` see https://github.com/olbat/dockerfiles/issues/103#issuecomment-2187149476


## Add printers to the Cups server
1. Connect to the Cups server at [http://127.0.0.1:631](http://127.0.0.1:631)
2. Add printers: Administration > Printers > Add Printer

__Note__: The admin user/password for the Cups server is `print`/`print`

## Configure Cups client on your machine
1. Install the `cups-client` package
2. Edit the `/etc/cups/client.conf`, set `ServerName` to `127.0.0.1:631`
3. Test the connectivity with the Cups server using `lpstat -r`
4. Test that printers are detected using `lpstat -v`
5. Applications on your machine should now detect the printers!

### Included package
* cups, cups-client, cups-filters
* foomatic-db
* printer-driver-all, printer-driver-cups-pdf
* openprinting-ppds
* hpijs-ppds, hp-ppd
* sudo, whois
* smbclient

### Troubleshooting
This Dockerfile can be used to build an image is containing most of the printing drivers packaged by Debian's team and allows to run a CUPS daemon to create a remote print server.

Now, this is as good as it gets! This repository has nothing to do with maintaining/debugging/supporting printer drivers packaged in Debian or the CUPS service.

If you need support on those topics, please try to reach out to the relevant support channels:
- [Debian forums](http://forums.debian.net/)
- [Debian "printing" team](https://wiki.debian.org/Teams/Printing)
- [cups mailing list](https://lists.cups.org/mailman/listinfo/cups)
- or one of the many other options you could easily find using your favorite search engine!

If you have some questions about how to start the container, make it accessible through your local network, run it on your NAS, etc. again, this is not the good place to ask them. 

In that case, please reach out to the relevant support channels. If you have an issue related to Docker's networking, I also strongly advise you to have a look at Docker's [documentation page](https://docs.docker.com/network/) on that topic to get a good grasp on the main concepts in play.
