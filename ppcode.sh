rm pretty-print-for-code.tex
touch pretty-print-for-code.tex

{
echo "\documentclass{article}"
echo "\usepackage[utf8]{inputenc}"
echo "\usepackage[margin=0.8in]{geometry}"
echo "\usepackage{listings}"
echo "\usepackage{xcolor}"
echo "\definecolor{codegray}{rgb}{0.5,0.5,0.5}"
echo "\lstdefinestyle{mystyle}{"
echo "	frame=single,"
echo "	numberstyle=\small\ttfamily\color{codegray},"
echo "	basicstyle=\linespread{0.95}\ttfamily,"
echo "	breakatwhitespace=false,"
echo "	breaklines=true,"
echo "	keepspaces=true,"
echo "	numbers=left,"
echo "	numbersep=5pt,"
echo "	showstringspaces=false,"
echo "	showtabs=false,"
echo "	tabsize=4"
echo "}"
echo "\lstset{style=mystyle}"
echo "\begin{document}"
echo "\lstlistoflistings"
} > pretty-print-for-code.tex

function print-a-file {
    echo "\newpage"
    echo "\begin{lstlisting}[caption={$( echo "${1//_/\\_}" )}, language=C++]"
    cat $1
    echo "\end{lstlisting}"
}

for file in $(ls -r *.h *.c *.cpp)
do
    print-a-file $file >> pretty-print-for-code.tex
done

echo "\end{document}" >> pretty-print-for-code.tex

xelatex pretty-print-for-code.tex
xelatex pretty-print-for-code.tex

f=$(echo $(pwd) | base64)
# mv pretty-print-for-code.pdf $f.pdf
# lp -d Canon-iR2535-2545-UFRII-LT $f.pdf -o duplex
mv pretty-print-for-code.pdf $f
rm pretty-print-for-code.*
