# NOTAM parser

A gem to parse ICAO code and aerodrome hours of ops/service.

## Installation

Add this line to your application's Gemfile:

    gem 'dmg-notam-parser', git: 'https://github.com/dmgr/dmg-notam-parser.git'

And then execute:

    $ bundle

## Usage

    require 'dmg/notam/record'
    notam_record = Dmg::Notam::Record.new notam_raw_text
    p notam_record.icao_code
    p notam_record.opening_hours