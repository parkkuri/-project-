setwd("C:\\Users\\myungjun\\Desktop\\명준\\2017-1\\경영프로그래밍\\project\\sk")
library(stringr)

sk<-readLines("sklist.txt", encoding ="UTF-8")#RHINO를 거친 output파일을 불러온다.
splt_sk<-str_split(sk,", ")#','로 연결되어 이루어진 sk를 split한다. 
sort.sk<-sort(table(splt_sk), decreasing = TRUE)#단어들을 table화하여 빈도표로 만들고 순서를 부여한다.
write.csv(sort.sk,"sk_freq_result.csv", row.names = FALSE)#명사빈도표 생성
#stopword 제거하기
sk_f<-read.csv("sk_freq_result.csv", stringsAsFactors = F)
stopword<-readLines("stopwords.txt", encoding = "UTF-8")
a<-sk_f$splt_sk
aa<-c()
for(i in 1: length(stopword)){
  dd<-grep(paste0("^",stopword[i],"$"),a)
  aa<-c(aa,dd)
}
sk_f<-sk_f[-aa,]
write.csv(sk_f,"sk_final.csv", row.names = F)