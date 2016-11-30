posts=$(patsubst %.org,%.html,$(wildcard *.org))   \
			$(patsubst %.org,%.html,$(wildcard */*.org)) \
			$(patsubst %.md,%.html,$(wildcard *.md))     \
			$(patsubst %.md,%.html,$(wildcard */*.md)) 

css=$(patsubst %.sass,%.css,$(wildcard *.sass))

imgs=$(patsubst %.jpg,%.s.jpeg,$(wildcard */*/*.jpg)) \

pandoc_opts=--template=bogwonch --include-in-header ${css} -s

html_minimize=html-minifier --collapse-{boolean-attributes,whitespace} --remove-{attribute-quotes,comments,empty-attributes,empty-elements,optional-tags,redundant-attributes} | awk 'NF'

all: ${imgs} ${css} | ${posts} 
posts: ${posts}
publish: all
	@rsync -azP --exclude '*.jpg' --exclude '.*' * bogwonch.net:/var/www/html/

%.html: %.org bogwonch.html5 ${css} 
	@echo "[INFO] updating HTML for ${<}"
	@pandoc -t html5 -f org ${pandoc_opts} "${<}" -o "${@}"
	@html-image-inliner ${@} | ${html_minimize} | sponge "${@}"

%.html: %.md bogwonch.html5 ${css}
	@echo "[INFO] updating HTML for ${<}"
	@pandoc -t html5 -f markdown ${pandoc_opts} "${<}" -o "${@}" 
	@html-image-inliner ${@} | ${html_minimize} | sponge "${@}"

# DJPEG and CJPEG are part of the mozjpeg package
%.s.jpeg: %.jpg
	@echo "[INFO] compressing ${<}"
	@convert "${<}" -resize '1048576@>' "${<}"
	@djpeg "${<}" | cjpeg -quality 5 -optimize -rgb -progressive >"${@}"

# In practice this isn't worth it
%.svg: %.ppm
	@echo "[INFO] rasterizing ${<}"
	@potrace -s "${<}" -o "${@}"

%.ppm: %.jpg
	@echo "[INFO] converting ${<} for rasterization"
	@convert "${<}" -resize '1048576@>' "${@}"

%.css: %.sass
	@echo "[INFO] updating stylesheet ${<}"
	@sass --style compressed "${<}" "${@}" 
