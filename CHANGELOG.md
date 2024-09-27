# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
* `sorbet-runtime` dependency.
* Proper documentation in code for `Muina::Maybe` and its subclasses.
* Strictly typed `Muina::Maybe` and its subclasses.
* Following sections to the `README`: 
  * Installation
  * Documentation
  * Changelog
  * Development Standards
  * Supported Ruby Versions
  * Contributing
  * License


### Removed
* `muina` no longer uses `zeitwerk`.


## [0.6.0] - 2024-06-08
### Added
* `Muina::Maybe#some` alias for `Muina::Maybe#return`.
* `Muina::Error` as main error class.
* `Muina::Maybe::UnwrappingError` for `Muina::Maybe::None#value!`.


## [0.5.0] - 2024-06-03
### Added
* `Muina::Maybe::Some#==`
* `Muina::Maybe::None#==`


## [0.4.0] - 2024-06-02
### Added
* `Muina::Result`


## [0.3.0] - 2024-06-02
### Added
* `Muina::Maybe`


## [0.2.1] to [0.2.8] - 2021
Changelog entries missing.


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
