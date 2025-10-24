Useful CLI command to rebuild the PDF whenever the .tex changes:

```
while inotifywait -e close_write ioi_syllabus.tex; do  xelatex ioi_syllabus.tex ; done
```

Open the PDF in a good viewer (e.g. zathura) so that it refreshes when the file
changes.
