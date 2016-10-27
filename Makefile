posts=$(patsubst %.org,%.html,$(wildcard *.org))   \
			$(patsubst %.org,%.html,$(wildcard */*.org)) \
			$(patsubst %.md,%.html,$(wildcard *.md))     \
			$(patsubst %.md,%.html,$(wildcard */*.md)) 

css=$(patsubst %.sass,%.css,$(wildcard *.sass))

imgs=$(patsubst %.jpg,%.s.jpeg,$(wildcard */*/*.jpg))

pandoc_opts=--template=bogwonch --include-in-header ${css} -s

html_minimize=html-minifier --html5 --collapse-{boolean-attributes,inline-tag-whitespace,whitespace} --remove-{attribute-quotes,comments,empty-attributes,empty-elements,optional-tags,redundant-attributes,{script,style-link}-type-attributes,tag-whitespace}

all: ${posts} ${css} ${imgs}

%.html: %.org bogwonch.html5 ${css}
	@echo "[INFO] updating HTML for ${<}"
	@pandoc -t html5 -f org ${pandoc_opts} "${<}" | ${html_minimize} -o "${@}"

%.html: %.md bogwonch.html5 ${css}
	@echo "[INFO] updating HTML for ${<}"
	@pandoc -t html5 -f markdown ${pandoc_opts} "${<}" | ${html_minimize} -o "${@}"

# DJPEG and CJPEG are part of the mozjpeg package
%.s.jpeg: %.jpg
	@echo "[INFO] compressing ${<}"
	@convert "${<}" -resize '1048576@>' "${<}"
	@djpeg "${<}" | cjpeg -quality 5 -optimize -rgb -progressive >"${@}"

%.css: %.sass
	@echo "[INFO] updating stylesheet ${<}"
	@sass --style compressed "${<}" "${@}" 
