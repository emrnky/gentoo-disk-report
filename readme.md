# Gentoo Disk Report 
This is a simple cli tool built with bash, to monitor gentoo specific cache directories


```bash 
git clone git@github.com:emrnky/gentoo-disk-report.git
cd gentoo-disk-report
chmod +x *.sh src/*.sh
git clone git@github.com:emrnky/browser_cleanup_tools.git 
cd browser_cleanup_tools
chmod +x *.sh lib/*.sh 
cd ..

## Example
# ./run.sh
```


# Optional Config files

## Logrotate

Pass extra logs dir for logrotate tool by running below script.

Script needs sudo acces in order to write in the logrotate.d configurations directory.

*Below config is safe to add, directly taken from [gentoo logrotate wiki page](https://wiki.gentoo.org/wiki/Logrotate#Portage_logrotate_module).*

List of configs
    + Portage
    ...

```bash
sudo ./portage-logrotate.sh

## Then check with :
cat /etc/logrotate.d/portage
```
