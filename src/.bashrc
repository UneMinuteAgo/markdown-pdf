export LANG='C.UTF-8'


# 
# Rend un document Markdown en document HTML
#	$1 : Fichier Markdown à rendre
#   $2 : Classe à ajouter au body si nécessaire
#   $3 : Feuille de style à utiliser : .markdown-pdf-stylesheet-$3.css
#
makehtml() {
	cat ~/.markdown-pdf-hljs-monokaiSublime.css > mhtml.css


	# Utiliser la feuille de style spécifiée
	if [ $3 ]; then
		sheet=".markdown-pdf-stylesheet-$3.css"
		
		if [ ! -f ~/$sheet ]; then
			echo "File $sheet not found in $HOME"
			return 1
		fi
		
		cat ~/$sheet >> mhtml.css
	else
		cat ~/.markdown-pdf-stylesheet.css >> mhtml.css
	fi
	
	showdown makehtml -i $1 -o $1.tmp --tables --tasklists
	
	sed -e "s/%TITLE%/$1/g" ~/.markdown-html-wrapper.html |	
	    sed -e "s/%CLASS%/$2/g" |
		sed -e '/%STYLE_CSS%/{r mhtml.css' -e 'd}' |
		sed -e "/%MARKDOWN_HTML%/{r $1.tmp" -e 'd}' > $1.html
		
	rm mhtml.css
	rm $1.tmp
	
	return 0
}

#
# Rend un document Markdown en document PDF
#	$1 : Fichier Markdown à rendre
#   $2 : Fichier JS à exécuter pour générer l'entête et le pied de page
#   $3 : Feuille de style à utiliser : .markdown-pdf-stylesheet-$3.css
#   $4 : Feuille de style pour Highlight.js : .markdown-pdf-hljs-$4.css
#
mpdf(){
	# Defaults:
	# Fichier Markdown à rendre
	mdfile=""
	js=""
	hljs="monokaiSublime"
	css=""
	preset=""

	run="--runnings-path $HOME/.markdown-pdf-default.js"
	sheet=".markdown-pdf-stylesheet.css"
	
	# Traitement des options
	#	$1 = Fichier
	#   $2 = runnings-path
	#   $3 = Stylesheet
	#   $4 = Highlight.js Stylesheet
	arg=0
	for i in "$@"; do
		((++arg))

		case $i in
			--js=*)
				js="${i#*=}"
			;;
			--theme=*|--css=*)
				css="${i#*=}"
			;;
			--file=*)
				mdfile="${i#*=}"
			;;
			--hl=*|--hljs=*)
				hljs="${i#*=}"
			;;
			--preset=*)
				preset="${i#*=}"
			;;
			*)
				if [ $arg = 1 ]; then
					mdfile=$i
				elif [ $arg = 2 ]; then
					js=$i
				elif [ $arg = 3 ]; then
					css=$i
				elif [ $arg = 4 ]; then
					hljs=$i
				fi
			;;
		esac
	done

	if [ $preset ]; then
		case $preset in
			viseo)
				js="viseo"
				css="viseo"
				hljs="viseo"
			;;
			uma)
				js="uma"
				css="uma"
			;;
		esac
	fi

	if [ $js ]; then
		if [ $js = 'off' ] || [ $js = 'disable' ]; then
			echo "disable"
			run=''
		else
			run="--runnings-path $HOME/.markdown-pdf-$js.js"

			if [ ! -f ~/.markdown-pdf-$js.js ]; then
				echo "File .markdown-pdf-$js.js not found in $HOME"
				return 1
			fi
		fi
	fi

	if [ $css ]; then
		sheet=".markdown-pdf-stylesheet-$css.css"
		if [ ! -f ~/$sheet ]; then
			echo "File $sheet not found in $HOME"
			return 1
		fi
	fi

	hljssheet=".markdown-pdf-hljs-$hljs.css"

	if [ ! -f ~/$hljssheet ]; then
		echo "File $hljssheet not found in $HOME"
		return 1
	fi

	markdown-pdf -m '{"breaks": false, "html": true, "linkyfy": true}' --paper-border "0cm" --css-path ~/$sheet --highlight-css-path ~/$hljssheet $run $mdfile

	return 0
}

alias dpng='dot -Tpng -O'
alias dsvg='dot -Tsvg -O'
alias eazybi='/c/Logiciels/Notepad++/notepad++.exe "/c/NDU90045/Desktop/EazyBI/1- EazyBIConfigDataSource-v1.0.1.js" "/c/NDU90045/Desktop/EazyBI/1- Liste Référent Trigramme - Full Name - v1.1.txt" 2>/dev/null || true &'
alias fall='egrep . --color -nre'
alias npp='/c/Logiciels/Notepad++/notepad++.exe'
alias mhtml='makehtml'


# Archive
#alias mpdf='markdown-pdf -m '"'"'{"breaks": false, "html": true, "linkify": true}'"'"' --css-path ~/.markdown-pdf-stylesheet.css --highlight-css-path ~/.markdown-pdf-monokai-sublime.css'
