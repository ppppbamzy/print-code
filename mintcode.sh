#!/bin/bash
rm pretty-print-for-code.* 2>/dev/null
touch pretty-print-for-code.tex
root=$(pwd)

{
echo "\documentclass[12pt]{article}"
echo "\usepackage[utf8]{inputenc}"
echo "\usepackage[T1]{fontenc}"
echo "\usepackage[paperwidth=9.2in,paperheight=6.9in,margin=0.5in]{geometry}"
echo "\usepackage{xeCJK}"
echo "\setmainfont{Linux Libertine O}"
echo "\setmonofont{Cascadia Code}"
echo "\setCJKmonofont{楷体-简}"
echo "\usepackage{minted}"
echo "\begin{document}"
echo "\tableofcontents"
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
    echo "\addcontentsline{toc}{subsection}{$cap}"
    echo "\subsection*{$cap}"
    echo "\begin{minted}[frame=single,framesep=10pt,breaklines]{cpp}"
    echo "// $1"
    cat $1
    echo "\end{minted}"
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

    for file in $(ls -r *.c *.cpp *.h 2>/dev/null)
    do
        print-a-file $file >> "$root/pretty-print-for-code.tex"
    done
}

print-cur-dir

echo "\end{document}" >> "$root/pretty-print-for-code.tex"

xelatex -shell-escape pretty-print-for-code.tex | grep '\['
xelatex -shell-escape pretty-print-for-code.tex | grep '\['
