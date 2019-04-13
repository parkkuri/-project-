setwd("C:\\Users\\myungjun\\Desktop\\명준\\2017-1\\경영프로그래밍\\project\\lg")
library(stringr)

lg<-readLines("lglist.txt", encoding ="UTF-8")#RHINO를 거친 output파일을 불러온다.
splt_lg<-str_split(lg,", ")#','로 연결되어 이루어진 lg를 split한다. 
sort.lg<-sort(table(splt_lg), decreasing = TRUE)#단어들을 table화하여 빈도표로 만들고 순서를 부여한다.
write.csv(sort.lg,"lg_freq_result.csv", row.names = FALSE)#명사빈도표 생성
#stopword 제거하기
lg_f<-read.csv("lg_freq_result.csv", stringsAsFactors = F)
stopword<-readLines("stopwords.txt", encoding = "UTF-8")
a<-lg_f$splt_lg
aa<-c()
for(i in 1: length(stopword)){
  dd<-grep(paste0("^",stopword[i],"$"),a)
  aa<-c(aa,dd)
}
lg_f<-lg_f[-aa,]
write.csv(lg_f,"lg_final.csv", row.names = F)