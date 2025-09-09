#!/bin/bash
# Ferma la lettura avviata con leggi.sh

if [ -f /tmp/pico_tts_pid ]; then
    PID=$(cat /tmp/pico_tts_pid)
    if kill -0 $PID 2>/dev/null; then
        kill $PID
        echo "⏹️ Lettura interrotta."
    else
        echo "Nessuna lettura attiva."
    fi
    rm /tmp/pico_tts_pid
else
    echo "Nessuna lettura in corso."
fi
