.PHONY: all clean count

all: pubget.pdf

pubget.pdf: pubget.md figures/figure_1.png figures/figure_2.png
	pandoc $< -o $@

figures/figure_%.png: figures/figure_%.svg
	inkscape $< --export-filename $@ --export-area-drawing -w 1000

clean:
	rm -f figures/figure_*.png pubget.pdf

count:
	sed -n '1,/^# Body/d;/^# Figures/,$$d;/^#/{n;d};p' pubget.md | wc
