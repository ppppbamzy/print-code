#!/bin/bash
rm pretty-print-for-code.tex
touch pretty-print-for-code.tex
root=$(pwd)

{
echo "\documentclass[a4paper]{article}"
echo "\usepackage[utf8]{inputenc}"
echo "\usepackage[margin=0.5in]{geometry}"
echo "\usepackage{listings}"
echo "\usepackage[bookmarks]{hyperref}"
echo "\usepackage{xcolor}"
echo "\definecolor{codegray}{rgb}{0.5,0.5,0.5}"
echo "\definecolor{codeblue}{rgb}{0,0,0.5}"
echo "\lstdefinestyle{mystyle}{"
echo "  columns=fullflexible,"
echo "	frame=single,"
echo "	numberstyle=\small\ttfamily\color{codegray},"
echo "	commentstyle=\color{codeblue},"
echo "	basicstyle=\small\linespread{0.95}\ttfamily,"
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
echo "\usepackage{fontspec}" 
echo "\setmonofont[ItalicFont=LinLibertineO, Contextuals=Alternate]{Fira Code}"
echo "\begin{document}"
echo "\lstlistoflistings"
} > "$root/pretty-print-for-code.tex"

function print-a-file {
    # echo "\newpage"
    curpath=$(pwd)
    prefix="$(cd .. && pwd)"
    curpath=${curpath#"$prefix"}
    cap="${curpath//_/\\_}/${1//_/\\_}"
    echo "\pdfbookmark[0]{$cap}{$cap}"
    echo "\begin{lstlisting}[caption={$cap}, language=C++]"
    cat $1
    echo "\end{lstlisting}"
}

function print-cur-dir {
    for dir in $(ls -d */)
    do
        cd $dir
        print-cur-dir
        cd ..
    done

    # rm readme.h
    # if [ -f README ]; then
    #     (echo "/*"; cat README; echo "*/") >> readme.h
    # fi

    for file in $(ls -r *.c *.cpp *.h)
    do
        print-a-file $file >> "$root/pretty-print-for-code.tex"
    done
}

print-cur-dir

echo "\end{document}" >> "$root/pretty-print-for-code.tex"

xelatex pretty-print-for-code.tex
xelatex pretty-print-for-code.tex

# f=$(echo $(pwd) | base64)
# mv pretty-print-for-code.pdf $f.pdf
# lp -d Canon-iR2535-2545-UFRII-LT $f.pdf -o duplex
# mv pretty-print-for-code.pdf "$f"
# rm pretty-print-for-code.*
