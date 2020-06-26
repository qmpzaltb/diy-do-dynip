# DIY-DO-DYNIP

A simple **D**o-**I**t-**Y**ourself **D**igital**O**cean **Dyn**amic**IP** solution.

## Why?

Imagine you've got a computer at home and a domain name.
You want to be able to access that computer from anywhere using that domain.
Sounds easy enough, just make sure the DNS points to your home's IP address, right?

Not quite. Residential IP addresses are rarely static.
In order to make sure that the DNS always points to your home's address, you'll have to keep updating that entry.

This script does just that.

## Setup

### Requirements

The machine that the script will run on will need to be able to run the following:
    - `bash`
    - `curl`
    - `dig`

In order for the script to be useful, you will also need:
    - a DigitalOcean account,
    - a domain name that points to DigitalOcean's name servers, and
    - an API key that can do the needful with your domain names configured in DigitalOcean.

In order to run the script every so often, you'll need a scheduler such as `cron`.

### Setting it Up

First, you'll need to get the script onto your machine somehow.
You could clone the repo, `wget`/`curl` a file, copy-paste through a terminal, use a floppy disk - it doesn't really matter.

> :lock: **SECURITY WARNING:**  You should make sure that only you have access to the system the script is on!  
> If someone finds and reads the file with your API key in it (or reads the API key from the arguments to `curl`), you're going to have a bad time.

After the script is on your machine, you will need to edit the variables in the script.
The variables are in the top half of the script.
Hopefully it's documented well enough that you understand where the variables come from and what they do.

You will also want to make sure that the script is executable, just in case:
```sh
chmod +x dynip.sh
```

Finally, you will need to set up the script so that it is automatically run every so often.
You can do this with a `cron` job, which is quite simple to set up.

First, run `crontab -e`. Then, in crontab's editor of your choosing, enter the frequency of how often you wish the script to run and the path to the script.
For example, the following line will run the script at 3:33 AM, every day, month, and day of the week.
```
33 3 * * * /home/user/auto/dynip.sh
```

Then you're done! You can run the script manually a few times for good measure.
