#!/bin/zsh

MIN_MOVE=-500
MAX_MOVE=500

# Set environment variable, useful for stopping infinite loop
launchctl setenv STOP_MOUSE_MOVE_APP 0

sleep 1

while true
do
  # Check if should stop running
  SHOULD_STOP_RUNNING=$(launchctl getenv STOP_MOUSE_MOVE_APP)
  echo $SHOULD_STOP_RUNNING
  if [ "$SHOULD_STOP_RUNNING" -eq "1" ]; then
    break
  fi

  # Move mouse
  X_MOVE=$(( RANDOM % ( $MAX_MOVE - $MIN_MOVE + 1 ) + $MIN_MOVE ))
  if [ "$X_MOVE" -gt "0" ]; then
    X_MOVE="+$X_MOVE"
  fi

  Y_MOVE=$(( RANDOM % ( $MAX_MOVE - $MIN_MOVE + 1 ) + $MIN_MOVE ))
  if [ "$Y_MOVE" -gt "0" ]; then
    Y_MOVE="+$Y_MOVE"
  fi

  MOVE_EASE=$(( RANDOM % ( 300 - 100 + 1 ) + 100 ))

  /opt/homebrew/bin/cliclick -e $MOVE_EASE m:$X_MOVE,$Y_MOVE

  # Perform right-click
  DO_RC=$(( RANDOM % ( 1 - 0 + 1 ) + 0 ))
  if [ "$DO_RC" -eq "1" ]; then
    sleep 1

    /opt/homebrew/bin/cliclick rc:. w:250 kp:esc
  fi

  # Perform random keypress
  DO_KP=$(( RANDOM % ( 1 - 0 + 1 ) + 0 ))
  if [ "$DO_KP" -eq "1" ]; then
    sleep 1

    /opt/homebrew/bin/cliclick w:100 kp:esc w:100 kd:alt w:100 ku:alt w:100 kd:cmd w:100 ku:cmd w:100 kd:ctrl w:100 ku:ctrl w:100 kd:cmd w:100 ku:cmd w:100 kd:ctrl w:100 ku:ctrl
  fi

  # Perform switch tab (ctrl+tab keypress)
  DO_STAB=$(( RANDOM % ( 1 - 0 + 1 ) + 0 ))
  if [ "$DO_STAB" -eq "1" ]; then
    sleep 1

    /opt/homebrew/bin/cliclick w:100 kd:ctrl w:100 kp:tab w:100 ku:ctrl
  fi

  # Reset mouse position
  DO_RESET=$(( RANDOM % ( 1 - 0 + 1 ) + 0 ))
  if [ "$DO_RESET" -eq "1" ]; then
    sleep 1

    /opt/homebrew/bin/cliclick m:750,500
  fi

  sleep $(( RANDOM % ( 3 - 1 + 1 ) + 1 ))
done


# #!/bin/zsh

# launchctl setenv STOP_MOUSE_MOVE_APP 1

# sleep 1

# pkill -f "MV.app" > /dev/null 2>&1

# exit 0
