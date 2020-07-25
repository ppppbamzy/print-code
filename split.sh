gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -sPageList=odd -sOutputFile=0__odd.pdf $1
pl=""
for((i=$2;i>0;i-=2))
do
  inv=$(printf "%03d" $(($2-i)))
  # echo $inv
  gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -sPageList=$i -sOutputFile=even_$inv $1
done
gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -sOutputFile=1_even.pdf even*
rm even*
