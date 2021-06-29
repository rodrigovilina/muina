# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.0] - 2021-06-28

### Added

* Muina::Action: step based result returning services
* Muina::Result#{value!,error!,and_then,or_else}: safe and unsafe ways of unwrapping values and errors

### Removed

* Muina::Result#{value,error}


## [0.1.1] - 2021-06-22

### Fixed

* Add missing `zeitwerk` dependency to gemspec


## [0.1.0] - 2021-06-21

### Added

* Muina::Params: self extracting typed params
* Muina::PrivateCreation: mixin to make `.new` and `.allocate` private
* Muina::Result: type safe result monad
* Muina::Service: service object with typesafe constants and attributes
* Muina::Value: typesafe immutable struct-like objects
* `muina` CLI: to copy bundled rbi file
