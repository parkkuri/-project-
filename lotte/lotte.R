setwd("C:\\Users\\myungjun\\Desktop\\명준\\2017-1\\경영프로그래밍\\project\\lotte")
library(stringr)

lotte<-readLines("lottelist.txt", encoding ="UTF-8")#RHINO를 거친 output파일을 불러온다.
splt_lotte<-str_split(lotte,", ")#','로 연결되어 이루어진 lotte를 split한다. 
sort.lotte<-sort(table(splt_lotte), decreasing = TRUE)#단어들을 table화하여 빈도표로 만들고 순서를 부여한다.
write.csv(sort.lotte,"lotte_freq_result.csv", row.names = FALSE)#명사빈도표 생성
#stopword 제거하기
lotte_f<-read.csv("lotte_freq_result.csv", stringsAsFactors = F)
stopword<-readLines("stopwords.txt", encoding = "UTF-8")
a<-lotte_f$splt_lotte
aa<-c()
for(i in 1: length(stopword)){
  dd<-grep(paste0("^",stopword[i],"$"),a)
  aa<-c(aa,dd)
}
lotte_f<-lotte_f[-aa,]
write.csv(lotte_f,"lotte_final.csv", row.names = F)
