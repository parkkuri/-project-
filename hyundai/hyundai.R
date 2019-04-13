setwd("C:\\Users\\myungjun\\Desktop\\명준\\2017-1\\경영프로그래밍\\project\\hyundai")
library(stringr)

hyundai<-readLines("hyundailist.txt", encoding ="UTF-8")#RHINO를 거친 output파일을 불러온다.
splt_hyundai<-str_split(hyundai,", ")#','로 연결되어 이루어진 hyundai를 split한다. 
sort.hyundai<-sort(table(splt_hyundai), decreasing = TRUE)#단어들을 table화하여 빈도표로 만들고 순서를 부여한다.
write.csv(sort.hyundai,"hyundai_freq_result.csv", row.names = FALSE)#명사빈도표 생성
#stopword 제거하기
hyundai_f<-read.csv("hyundai_freq_result.csv", stringsAsFactors = F)
stopword<-readLines("stopwords.txt", encoding = "UTF-8")
a<-hyundai_f$splt_hyundai
aa<-c()
for(i in 1: length(stopword)){
  dd<-grep(paste0("^",stopword[i],"$"),a)
  aa<-c(aa,dd)
}
hyundai_f<-hyundai_f[-aa,]
write.csv(hyundai_f,"hyundai_final.csv", row.names = F)