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
    echo "\begin{lstlisting}[caption={$1}, language=C++]"
    cat $1
    echo "\end{lstlisting}"
}

for file in $(ls -r *.h *.c *.cpp)
do
    print-a-file $file >> pretty-print-for-code.tex
done

echo "\end{document}" >> pretty-print-for-code.tex

xelatex pretty-print-for-code.tex

f=$(echo $(pwd) | base64)
mv pretty-print-for-code.pdf $f.pdf
rm pretty-print-for-code.*
