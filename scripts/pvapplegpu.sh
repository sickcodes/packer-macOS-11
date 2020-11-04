#!/usr/bin/env bash

# confirm the vmx file provided exists
if [[ -e $1 ]]; then
  echo "Updating $1"
else
  echo "The target vmx file $1 doesn't exist"
fi

VMX_FILE=$(sed -r "s/\s/\\\s/g" <<<$1)
echo $VMX_FILE

# svga.present
if (grep -q svga.present $1); then
  /opt/local/libexec/gnubin/sed -i 's/svga.present.*/svga.present="FALSE"/g' "$1"
else
  echo 'svga.present="FALSE"' >>"$1"
fi

# appleGPU0.present
if (grep -q appleGPU0.present "$1"); then
  /opt/local/libexec/gnubin/sed -i 's/appleGPU0.present.*/appleGPU0.present="TRUE"/g' "$1"
else
  echo 'appleGPU0.present="TRUE"' >>"$1"
fi

# appleGPU0.screenWidth
if (grep -q appleGPU0.screenWidth "$1"); then
  /opt/local/libexec/gnubin/sed -i 's/appleGPU0.screenWidth.*/appleGPU0.screenWidth=1920/g' "$1"
else
  echo 'appleGPU0.screenWidth=1920' >>"$1"
fi

# appleGPU0.screenHeight
if (grep -q appleGPU0.screenHeight "$1"); then
  /opt/local/libexec/gnubin/sed -i 's/appleGPU0.screenHeight.*/appleGPU0.screenHeight1080/g' "$1"
else
  echo 'appleGPU0.screenHeight=1080' >>"$1"
fi

# view the config
grep '^appleGPU0\|^svga' "$1"

exit 0