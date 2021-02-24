# cvgenerator.sh
# Script to generate the curriculum vitae in HTML, PDF, ODT and plain text

FROM=$1
TO=$2

if [[ "$1" != "" ]]; then
  FROM="$1"
else
  FROM="cv.md"
fi

if [[ "$2" != "" ]]; then
  TO="$2"
else
  TO="cv"
fi

echo "Welcome to the Curriculum Vitae generator!"

echo "Generating HTML..."
pandoc --standalone -c style.css --from markdown --to html5 -o $TO.html $FROM

echo "Generating PDF..."
# This changes the background color of the body in style.css from grey to white
# before to convert the HTML in to PDF.
sed -i "s#f2f2f2#fff#g" style.css
#~/Descargas/wkhtmltopdf-0.12.6/wkhtmltox/bin/wkhtmltopdf $TO.html --enable-local-file-access --load-error-handling ignore $TO.pdf
wkhtmltopdf $TO.html --enable-local-file-access --load-error-handling ignore $TO.pdf

# After conversion to PDF, change again the style.css
sed -i "s#fff#f2f2f2#g" style.css
# Adding top menu
sed -i "s#<header>#<header>\n<nav style='text-align: center'>Otros formatos: <a href='cv.pdf'>PDF</a>, <a href='cv.txt'>TXT</a></nav>#g" $TO.html

echo "Generating plain text..."
pandoc --standalone --from markdown --to plain -o $TO.txt $FROM

echo "Task finished!"
