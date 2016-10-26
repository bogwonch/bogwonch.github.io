posts=$(patsubst %.org,%.html,$(wildcard *.org))   \
			$(patsubst %.org,%.html,$(wildcard */*.org)) \
			$(patsubst %.md,%.html,$(wildcard *.md))     \
			$(patsubst %.md,%.html,$(wildcard */*.md)) 

css=$(patsubst %.sass,%.css,$(wildcard *.sass))

imgs=$(patsubst %.jpg,%.s.jpeg,$(wildcard */*/*.jpg))

all: ${posts} ${css} ${imgs}

%.html: %.org bogwonch.html5
	@echo "[INFO] updating HTML for ${<}"
	@pandoc -t html -f org --template=bogwonch.html5 "${<}" -o "${@}"

%.html: %.md bogwonch.html5
	@echo "[INFO] updating HTML for ${<}"
	@pandoc -t html -f markdown --template=bogwonch.html5 "${<}" -o "${@}"

# DJPEG and CJPEG are part of the mozjpeg package
%.s.jpeg: %.jpg
	@echo "[INFO] compressing ${<}"
	@convert "${<}" -resize '1048576@>' "${<}"
	@djpeg "${<}" | cjpeg -quality 5 -optimize -rgb -progressive >"${@}"

%.css: %.sass
	@echo "[INFO] updating stylesheet ${<}"
	@sass "${<}" "${@}" 
