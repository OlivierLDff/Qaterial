#!/bin/bash

find ../qml -regex '.*\.\(qml\|js\)' -exec js-beautify -r --config $(pwd)/../.jsbeautifyrc {} \;
