#!/bin/bash

INPUT=${1};
COLORS=${2:-64};
SCALE=${3:-50};

# Check if gifsicle is installed/in PATH
if [[ ! `command -v gifsicle` ]]; then
	echo 'gifsicle could not be found in your PATH and is' >&2;
	echo 'required for this script to behave as intended.' >&2;
	exit 1;
fi

# Check if minimum input parameter count is met (input filename)
if [[ $# -lt 1 ]]; then
	echo 'Minimum parameters not matched' >&2;
	echo 'A input file must be defined, at the very minimum' >&2;
	exit 2;
fi

# Check if input file is set
if [[ ! -n "${INPUT}" ]]; then
	echo 'Input file not defined' >&2;
	exit 3;
else
	# Check if input file exists and is readable
	if [[ ! -f "${INPUT}" ]]; then
		echo 'Input file not found or readable' >&2;
		exit 4;
	fi

	# Check if input file has gif extension
	EXTENSION=${INPUT##*.};
	if [[ "${EXTENSION,,}" != "gif" ]]; then
		echo 'Input file must be a GIF image' >&2;
		exit 5;
	fi
fi

echo -e "Scale:\t${SCALE}\nColors:\t${COLORS}\nInput:\t${INPUT}\nOutput:\t${INPUT%%.*}_${COLORS}colors_scale${SCALE}.${INPUT##*.}" >&2;
echo -e "Command:\n\tgifsicle -iV -O3 --careful --colors ${COLORS} --scale 0.${SCALE} ${INPUT} --output ${INPUT%%.*}_${COLORS}colors_scale${SCALE}.${INPUT##*.}"
sleep 2;

gifsicle -iV -O3 --careful --colors ${COLORS} --scale 0.${SCALE} ${INPUT} --output ${INPUT%%.*}_${COLORS}colors_scale${SCALE}.${INPUT##*.}
