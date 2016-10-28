#!/usr/bin/env python

import sys
import argparse
import subprocess
import json
import time

def main():
    argument_parser = construct_argument_parser()
    if len(sys.argv) <= 1:
        # Application run without arguments - print help by default
        argument_parser.print_help()
        return

    args = argument_parser.parse_args()

    if args.should_list:
        print("listing available simulators in JSON and quitting: ")
        print(pretty_json(get_simctl_devices_json(args.xcrun_path)))
        return

    device_udid = find_appropriate_device_udid(args.devicename, args.osversion, args.xcrunpath)
    if not device_udid:
        print("failed to find a device that matched parameters")
        sys.exit(1)
        return

    print device_udid

# Argument parsing

def construct_argument_parser():
    argument_parser = argparse.ArgumentParser(description='Core iOS Simulator UUID finder')
    argument_parser.add_argument('--list', dest='should_list', action='store_true',
                                 help='Dump simulator JSON list and quit without running')
    argument_parser.add_argument('-d', '--devicename', type=str, default='iPhone 7',
                                 help='Name of the device to run. For example: `iPhone 6`, `iPad Air 2`, `Apple Watch - 42mm`')
    argument_parser.add_argument('-o', '--osversion', type=str, default='iOS 10.0',
                                 help='Which OS version to run. For example: `iOS 8.4`, `iOS 9.0`, `watchOS 2.0')
    argument_parser.add_argument('-s', '--simulatorname', type=str, default='Simulator',
                                 help='The name of the simulator executable on your machine. For Example: `Simulator`, `iOS Simulator`')
    argument_parser.add_argument('-x', '--xcrunpath', type=str, default='xcrun',
                                 help='Path to the version of xcrun to use. For example: `xcrun`, `/path/to/xcode/version/xcrun`')
    argument_parser.set_defaults(should_list=False)

    return argument_parser

# Command running

def get_simctl_devices_list(xcrun_path):
    return subprocess.check_output([xcrun_path, "simctl", "list", "devices", "--json"])

# JSON wrangling

def get_simctl_devices_json(xcrun_path):
    simctl_devices = get_simctl_devices_list(xcrun_path)
    if not simctl_devices:
        print("failed to get simctl devices list")
        return

    json_simctl_devices = json.loads(simctl_devices)
    if not json_simctl_devices:
        print("failed to parse simctl devices list in to json")
        return

    return json_simctl_devices

def find_appropriate_device_udid(search_devicename, search_osversion, xcrun_path):
    json_simctl_devices = get_simctl_devices_json(xcrun_path)

    return find_appropriate_device_udid_in_json(json_simctl_devices, search_devicename, search_osversion)

def find_appropriate_device_udid_in_json(json_devices, search_devicename, search_osversion):
    for json_osversion in json_devices['devices']:
        devices_for_osversion = json_devices['devices'][json_osversion]

        if json_osversion != search_osversion:
            continue

        for json_device in devices_for_osversion:
            device_available = parse_is_device_available(json_device)
            device_name = parse_device_name(json_device)
            device_udid = parse_device_udid(json_device)

            if device_available and device_name == search_devicename:
                return device_udid

    return ""

def parse_is_device_available(device_json):
    device_availability = device_json['availability']

    if not device_availability:
        return False

    if "unavailable" in device_availability:
        return False

    if "available" in device_availability:
        return True

    return False

def parse_device_name(device_json):
    return device_json['name']

def parse_device_udid(device_json):
    return device_json['udid']

# Helper

def pretty_json(json_to_pretty):
    return json.dumps(json_to_pretty, sort_keys=True, indent=4, separators=(',', ': '))

# main

if __name__ == '__main__':
    main()
