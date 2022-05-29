#!/bin/bash

python3 generate.py
gcc source/*.c source/*.h -fPIC -shared -o output/put.so
if [$? -ne 0]; then
	echo "Failed"
else
	echo ""
	echo "Finished! And the log saved as ./output/log.txt."
	echo "You can find the interface.py and put.so in ./output"
	echo "You could test it in the following way:"
	echo "cd ./output"
	echo "python3"
	echo ">>>from interface import *"
	echo ">>>a = Interface()"
	echo ">>>..."
fi
