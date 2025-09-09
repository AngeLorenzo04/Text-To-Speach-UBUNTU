#!/bin/bash

# Controlla se xclip e pico2wave sono installati
for cmd in xclip pico2wave aplay; do
    if ! command -v $cmd &>/dev/null; then
        echo "Errore: $cmd non è installato."
        echo "Installa con: sudo apt install xclip libttspico-utils alsa-utils"
        exit 1
    fi
done

# Prende il testo evidenziato (primary selection)
TEXT=$(xclip -o -selection primary)

if [ -z "$TEXT" ]; then
    echo "Nessun testo evidenziato col mouse."
    exit 1
fi

# Genera audio temporaneo e lo riproduce
TMPFILE="/tmp/pico_tts.wav"
pico2wave -l=it-IT -w=$TMPFILE "$TEXT"
aplay $TMPFILE &
PID=$!

# Salva il PID per poter fermare la lettura
echo $PID > /tmp/pico_tts_pid
echo "📖 Lettura in corso... per fermarla esegui ./ferma.sh"

