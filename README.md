Therm Sensor [WIP]
===========

Part of the Therm temperature management system. This code is intended to be used on a Raspberry Pi to manage temperature by:

* interfacing with [temperature sensor hardware](https://www.adafruit.com/product/642), as well as
* hardware to heat or cool (TBD)
* POSTing those temperatures to the Therm API
* GETting a target temperature from the Therm API
* running cooling or heating routines to affect the temperature (based on the temperature readings and the retrieved target temperature)

Since this is in very early stages, my goal is to first just create a temperature logging system (by interfacing with the sensor hardware and posting the temps to the API). Once that's achieved, I plan to add the temperature modulation (heating and cooling).

Setup
=====
Required hardware:
* A temperature sensor. Any from [this list](https://github.com/timofurrer/w1thermsensor#supported-devices) should work.
* A Raspberry Pi (possibly works with other boards, but untested)

*Note: this currently requires Ruby 2.5 because I'm lazy and like using the latest and greatest.*

1. Wire up your temperature sensor to your Pi's board
1. Add a GPIO configuration line to your Pi's `/boot/config.txt`:

```
# configure gpio for temp sensor
dtoverlay=w1-gpio
```

The above configuration line will default to pin 4. To use a different pin, replace "x" in the below to the pin you would like to use:

```
dtoverlay=w1-gpio,gpiopin=x
```

1. Install [ThermSensor](https://github.com/timofurrer/w1thermsensor).

On a Raspberry Pi:
```
sudo apt-get install python3-w1thermsensor
```

1. Reboot: `sudo reboot`

You should now see some usage options when you enter `w1thermsensor` in your Pi's terminal. If not, you may want to consult the w1thermsensor [docs](https://github.com/timofurrer/w1thermsensor) or [issues](https://github.com/timofurrer/w1thermsensor/issues).

1. Clone this repo and `cd` into it:

```
git clone https://github.com/jpalmieri/therm-sensor && cd therm-sensor
```

1. Create config file from the example file:

```
cp config-example.yml config.yml
```

1. Replace info in config.yml with your [Therm](https://github.com/jpalmieri/therm) server's address and login information using your preferred text editor.




TODO
======
* Wrap [temperature sensor library](https://github.com/timofurrer/w1thermsensor) in a ruby interface
* Create scheduling system to periodically check and log temperature
* Create CLI
* Add GET for target temperature
* Add interfaces for heating and cooling mechanisms
* Create routines for heating and cooling
