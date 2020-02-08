#! /bin/bash
brightness_cmd="gdbus call -e -d de.mherzberg -o /de/mherzberg/wlrbrightness -m de.mherzberg.wlrbrightness.get| cut -c 2- | cut -c 1-3"

eval "$brightness_cmd"
