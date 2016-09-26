files=$(patsubst %.org,%.html,$(wildcard *.org)) \
			$(patsubst %.org,%.html,$(wildcard */*.org)) \
			$(patsubst %.sass,%.css,$(wildcard *.sass))

all: ${files} 

%.html: %.org bogwonch.html5
	pandoc -t html -f org --template=bogwonch.html5 "${<}" -o "${@}"

%.css: %.sass
	sass "${<}" "${@}" 
