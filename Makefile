.PHONY: all arxiv icml pack-arxiv pack-icml clean

all: arxiv icml

arxiv:
	cd arxiv && latexmk -pdf -interaction=nonstopmode main.tex

icml:
	cd icml && latexmk -pdf -interaction=nonstopmode main.tex

pack-arxiv:
	rm -rf dist/arxiv_submit dist/arxiv_submit.tar.gz dist/arxiv_submit.zip
	mkdir -p dist/arxiv_submit
	rsync -aL \
		--exclude='*.aux' --exclude='*.log' --exclude='*.out' \
		--exclude='*.fls' --exclude='*.fdb_latexmk' --exclude='*.synctex.gz' \
		--exclude='*.blg' --exclude='main.pdf' --exclude='.DS_Store' \
		arxiv/ dist/arxiv_submit/
	tar -czf dist/arxiv_submit.tar.gz -C dist/arxiv_submit .
	cd dist/arxiv_submit && zip -qr ../arxiv_submit.zip .
	@echo "Packaged self-contained arXiv source to dist/arxiv_submit/ (.tar.gz and .zip)"

pack-icml:
	rm -rf dist/icml_submit dist/icml_submit.tar.gz dist/icml_submit.zip
	mkdir -p dist/icml_submit
	rsync -aL \
		--exclude='*.aux' --exclude='*.log' --exclude='*.out' \
		--exclude='*.fls' --exclude='*.fdb_latexmk' --exclude='*.synctex.gz' \
		--exclude='*.blg' --exclude='main.pdf' --exclude='.DS_Store' \
		icml/ dist/icml_submit/
	tar -czf dist/icml_submit.tar.gz -C dist/icml_submit .
	cd dist/icml_submit && zip -qr ../icml_submit.zip .
	@echo "Packaged self-contained ICML source to dist/icml_submit/ (.tar.gz and .zip)"

clean:
	rm -rf dist/
	for dir in arxiv icml; do \
		rm -f $$dir/*.aux $$dir/*.log $$dir/*.out $$dir/*.bbl $$dir/*.blg $$dir/*.fls $$dir/*.fdb_latexmk $$dir/*.synctex.gz; \
	done
