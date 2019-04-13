setwd("C:\\Users\\myungjun\\Desktop\\명준\\2017-1\\경영프로그래밍\\project\\samsung")
library(stringr)

samsung<-readLines("samsunglist.txt", encoding ="UTF-8")#RHINO를 거친 output파일을 불러온다.
splt_sm<-str_split(samsung,", ")#','로 연결되어 이루어진 samsung을 split한다. 
sort.sm<-sort(table(splt_sm), decreasing = TRUE)#단어들을 table화하여 빈도표로 만들고 순서를 부여한다.
write.csv(sort.sm,"samsung_freq_result.csv", row.names = FALSE)#명사빈도표 생성

smg<-read.csv("samsung_freq_result.csv", stringsAsFactors = F)
stopword<-readLines("stopwords.txt", encoding = "UTF-8")
a<-smg$splt_sm
aa<-c()
for(i in 1: length(stopword)){
  dd<-grep(paste0("^",stopword[i],"$"),a)
  aa<-c(aa,dd)
}
smg<-smg[-aa,]
write.csv(smg,"samsung_final.csv", row.names = F)