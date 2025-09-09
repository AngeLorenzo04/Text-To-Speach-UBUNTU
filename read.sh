#!/bin/bash
# Legge il testo evidenziato col mouse in italiano usando pico2wave

# Controllo prerequisiti
for cmd in xclip pico2wave aplay; do
    if ! command -v $cmd &>/dev/null; then
        echo "Errore: manca $cmd. Installa con: sudo apt install xclip libttspico-utils alsa-utils"
        exit 1
    fi
done

# Acquisizione testo selezionato
TEXT=$(xclip -o -selection primary)
if [ -z "$TEXT" ]; then
    echo "Nessun testo evidenziato col mouse."
    exit 1
fi

# Generazione e riproduzione audio
TMPFILE="/tmp/pico_tts.wav"
pico2wave -l=it-IT -w="$TMPFILE" "$TEXT"
aplay "$TMPFILE" &
PID=$!

# Salvataggio PID per fermare la lettura
echo $PID > /tmp/pico_tts_pid
echo "Lettura in corso... per fermarla esegui ./ferma.sh"
