#!/bin/bash

# Whether the bg colors are spaced apart
spaced=false

for (( i = 0; i < 256; i++ )); do
	echo -en "  [38;5;${i}m"
	printf "%03d" $i
	if [ $i -eq  7 ] || [ $i -eq 15 ]; then echo; fi
	mod=$(((i-15) % 6))
	if [ $i -gt 15 ] && [ $i -lt 232 ] && [[ $mod -eq 0 ]]; then echo; fi
	if [ $i -eq  243 ] || [ $i -eq 255 ]; then echo; fi
done

echo;echo

echo -en "[38;5;231m"
for (( i = 0; i < 256; i++ )); do
	if $spaced; then echo -n "  "; fi
	echo -en "[48;5;${i}m "
	printf "%03d" $i
	echo -n " [49m"

	if [ $i -eq  7 ] || [ $i -eq 15 ]; then echo; if $spaced; then echo; fi; fi
	if [ $i -eq 15 ]; then echo; fi
	mod=$(((i-15) % 6))
	if [ $i -gt 15 ] && [ $i -lt 232 ] && [[ $mod -eq 0 ]]; then echo; if $spaced; then echo; fi; fi
	if [ $i -eq 231 ]; then echo; fi
	if [ $i -eq 243 ]; then echo; if $spaced; then echo; fi; fi

	if [ $i -eq 7 ]; then echo -en "[38;5;16m"; fi
	if [ $i -eq 15 ]; then echo -en "[38;5;253m"; fi
	if [ $i -eq 21 ]; then echo -en "[38;5;16m"; fi
	if [ $i -eq 51 ]; then echo -en "[38;5;253m"; fi
	if [ $i -eq 57 ]; then echo -en "[38;5;16m"; fi
	if [ $i -eq 231 ]; then echo -en "[38;5;231m"; fi
	if [ $i -eq 243 ]; then echo -en "[38;5;16m"; fi
done

echo;echo
