# Tutorial content examples for *adapativelearnr*

Markus Konrad <markus.konrad@htw-berlin.de>, June 2023

## Description

This application is for showing and testing features of the
[adaptivelearnr](https://github.com/IFAFMultiLA/adaptivelearnr) package, especially in terms of tracking and
communication with the web API.

## Installation

1. install the [renv](https://rstudio.github.io/renv/index.html) package
2. clone the main branch of the [adaptivelearnr repository](https://github.com/IFAFMultiLA/adaptivelearnr) to the folder
   `../adaptivelearnr`
3. call `renv::restore()` to install all dependencies

## Local development

- additionally to "Run document" in RShiny, you may use `make devserver` which will serve the application on
  `http://localhost:8000`

## Deployment

- the deployment can be controlled via `Makefile`
- it is necessary to adjust the host and paths in the `Makefile`
- install dependencies on the server via `make installdeps`
- simulate file transfer to the server via `make testsync`
- apply file transfer to the server via `make sync`
- use `make reload` to restart the app on the server – **this is necessary after each code update on the server**
