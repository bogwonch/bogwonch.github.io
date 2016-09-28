posts=$(patsubst %.org,%.html,$(wildcard *.org)) \
			$(patsubst %.org,%.html,$(wildcard */*.org))

css=$(patsubst %.sass,%.css,$(wildcard *.sass))

imgs=$(patsubst %.jpg,%.s.jpeg,$(wildcard */*/*.jpg))

all: ${posts} ${css} ${imgs}

%.html: %.org bogwonch.html5
	@echo "[INFO] updating HTML for ${<}"
	@pandoc -t html -f org --template=bogwonch.html5 "${<}" -o "${@}"

# DJPEG and CJPEG are part of the mozjpeg package
%.s.jpeg: %.jpg
	@echo "[INFO] compressing ${<}"
	@djpeg "${<}" | cjpeg -quality 5 -optimize -rgb -progressive >"${@}"

%.css: %.sass
	@echo "[INFO] updating stylesheet ${<}"
	@sass "${<}" "${@}" 
