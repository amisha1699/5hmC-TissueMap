#!bin/bash
BASE_DIR = "."
for DIR in "$BASE_DIR"/*; do
    if [ -d "$DIR"]; then
        TISSUE_TYPE=$(basename "$DIR")
        (
            for FILE in "$DIR"/*; do
                if [ -f "$FILE" ]; then

                    NUMBER=$(echo $(basename "$FILE") | sed -n 's/^.*'"$TISSUE_TYPE"'\([0-9]*\)_.*$/\1/p')

                    OUTPUT_FILE="${TISSUE_TYPE}${NUMBER}.txt"

                    annotatePeaks.pl "$FILE" ../hg19 -gtf ../gencode.v19.annotation.gtf_withproteinids > "$BASE_DIR/$TISSUE_TYPE/$OUTPUT_FILE"
                fi
            done
        ) &
    fi
done

wait
