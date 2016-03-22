# oraaud

#### Table of Contents

1. [Overview](#overview)
2. [Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with oraaud](#setup)
    * [What oraaud affects](#what-oraaud-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with oraaud](#beginning-with-oraaud)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)

## Overview

Puppet module to install Oracle database server auditing service on RHEL6.

## Module-Description

The oraaud Puppet module installs Oracle database server auditing for
RHEL 6.

The agent service ????? will be configured to start automatically.  The 
agent service process name is ?????.

## Setup

### What oraaud affects

### Setup Requirements **OPTIONAL**

### Beginning with oraaud

## Usage

To apply this module, assign the node the class 'oraaud' in the PE console,
then initiate a Puppet agent run with 'puppet agent -t' run from the node.

The following paramaters should be defined in Puppet console before assigning
this class to any nodes.

* ????	  ??????

## Reference

Classes<br>
::oraaud<br>
::oraaud::params<br>
::oraaud::install<br>
::oraaud::service<br>

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You may also add any additional sections you feel are
necessary or important to include here. Please use the `## ` header.
