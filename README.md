Therm Sensor [WIP]
===========

Part of the Therm temperature management system. This code is intended to be used on a Raspberry Pi to manage temperature by:

* interfacing with [temperature sensor hardware](https://www.adafruit.com/product/642), as well as
* hardware to heat or cool (TBD)
* POSTing those temperatures to the Therm API
* GETting a target temperature from the Therm API
* running cooling or heating routines to affect the temperature (based on the temperature readings and the retrieved target temperature)

Since this is in very early stages, my goal is to first just create a temperature logging system (by interfacing with the sensor hardware and posting the temps to the API). Once that's achieved, I plan to add the temperature modulation (heating and cooling).

TODO
======
* Wrap [temperature sensor library](https://github.com/timofurrer/w1thermsensor) in a ruby interface
* Create scheduling system to periodically check and log temperature
* Create CLI
* Add GET for target temperature
* Add interfaces for heating and cooling mechanisms
* Create routines for heating and cooling
