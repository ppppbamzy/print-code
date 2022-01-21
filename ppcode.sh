#!/bin/bash
rm pretty-print-for-code.tex 2>/dev/null
touch pretty-print-for-code.tex
root=$(pwd)

{
echo "\documentclass[a4paper]{article}"
echo "\usepackage[utf8]{inputenc}"
echo "\usepackage[margin=0.5in]{geometry}"
echo "\usepackage{listings}"
echo "\usepackage{listings-rust}"
echo "\usepackage[verbatim]{lstfiracode}"
echo "\usepackage[bookmarks]{hyperref}"
echo "\usepackage{xcolor}"
echo "\definecolor{codegray}{rgb}{0.5,0.5,0.5}"
echo "\definecolor{codeblue}{rgb}{0,0,0.5}"
echo "\lstdefinestyle{mystyle}{"
echo "    columns=fullflexible,"
echo "    frame=single,"
echo "    numberstyle=\small\ttfamily\color{codegray},"
echo "    commentstyle=\rm\color{codeblue},"
echo "    basicstyle=\small\linespread{0.95}\ttfamily,"
echo "    breakatwhitespace=false,"
echo "    breaklines=true,"
echo "    keepspaces=true,"
echo "    numbers=left,"
echo "    numbersep=5pt,"
echo "    showstringspaces=false,"
echo "    showtabs=false,"
echo "    tabsize=4"
echo "}"
echo "\lstset{style=mystyle}"
echo "\usepackage{fontspec}" 
echo "\setmainfont{LinLibertineO}"
echo "\setmonofont[Contextuals=Alternate]{Cascadia Code}"
echo "\begin{document}"
echo "\lstlistoflistings"
} > "$root/pretty-print-for-code.tex"

function print-a-file {
    # echo "\newpage"
    curpath=$(pwd)
    # prefix="$(cd .. && pwd)"
    prefix="$root"
    curpath=${curpath#"$prefix"}
    curpath=${curpath#"/"}
    if [[ $curpath == "" ]]; then
        cap="${1//_/\\_}"
    else
        cap="${curpath//_/\\_}/${1//_/\\_}"
    fi
    echo "\pdfbookmark[0]{$cap}{$cap}"
    echo "\begin{lstlisting}[caption={$cap}, language=C++]"
    cat $1
    echo "\end{lstlisting}"
}

function print-cur-dir {
    for dir in $(ls -d */ 2>/dev/null)
    do
        cd $dir
        print-cur-dir
        cd ..
    done

    # rm readme.h
    # if [ -f README ]; then
    #     (echo "/*"; cat README; echo "*/") >> readme.h
    # fi

    for file in $(ls -r *.c *.cpp *.h *.hpp 2>/dev/null)
    do
        print-a-file $file >> "$root/pretty-print-for-code.tex"
    done
}

print-cur-dir

echo "\end{document}" >> "$root/pretty-print-for-code.tex"

xelatex pretty-print-for-code.tex | grep '\['
xelatex pretty-print-for-code.tex | grep '\['

f=$(echo $(pwd) | base64)
mv pretty-print-for-code.pdf $f.pdf
rm pretty-print-for-code.*
