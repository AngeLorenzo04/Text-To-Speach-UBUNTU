#!/bin/bash

if [ -f /tmp/pico_tts_pid ]; then
    PID=$(cat /tmp/pico_tts_pid)
    if kill -0 $PID 2>/dev/null; then
        kill $PID
        rm /tmp/pico_tts_pid
        echo "⏹️ Lettura interrotta."
    else
        echo "Nessuna lettura attiva."
        rm /tmp/pico_tts_pid
    fi
else
    echo "Nessuna lettura in corso."
fi

