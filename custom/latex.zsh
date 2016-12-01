export PATH="$PATH:/Library/TeX/texbin"

LATEX="$DOTDIR/assets/LaTeX"

genpdf() {
    # Link to template
    doc="$($LATEX/linker.py $@)"

    if [ $? -eq 0 ]; then
        # Grab filename
        name="$(echo $1 | cut -d \. -f 1)"
        tmpname="linked-$name"

        # Generate PDF-file
        ruby -e "puts('$doc')" > "$tmpname.tex"
        pdflatex "$tmpname.tex"

        if [ $? -eq 0 ]; then
            # Rename PDF-file
            mv "$tmpname.pdf" "$name.pdf"
            rm "$tmpname"* "texput"*
        fi
    fi
}
