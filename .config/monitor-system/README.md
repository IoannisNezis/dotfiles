# Monitor the Battery

This program can be used to monitor the battery consumption of your system.  

It measures the:
 - energy
 - rate
 - state
of your battery every 5s.  

The data is stored in the RDF format.

The hole thing is highly experimental and not save or stable at all!  
I just wanted to get some usable data as fast as possible.


## Installation

Replace `ianni` with your username in `./monitor-battery.service`.

If you have `just` installed run:

``` bash
just install
```

If you do not have just installed, install [just](https://github.com/casey/just)

## Usage

``` bash
just start
```

The data will now be logged to `~/.local/state/monitor-battery/data.rdf` whenever you boot your os.
