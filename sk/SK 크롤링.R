library(XML)
library(stringr)
library(rvest)

setwd("c:\\r_temp") 
getwd()

all.url<-c()
all.text  <- c()

urlall <- "http://www.jobkorea.co.kr/Starter/PassAssay/View/"
for(EEE in 144296:145000){
  url <- paste(urlall,EEE,"?Page=1&OrderBy=0&FavorCo_Stat=0&Pass_An_Stat=0",sep="")
  jasoju <- read_html(url)
  if(str_detect(jasoju,"선택하신 합격자소서 정보가 없습니다.")==T){
    next
  }else{
    b<-html_nodes(jasoju, 'title')
  } 
  if(str_detect(b,'SK')==F){
    next
  }else{
    tx <- html_nodes(jasoju, "div.tx")
    
    text <- html_text(tx[!str_detect(tx, "href")])
    text <- str_replace_all(text,"글자수","")
    text <- str_replace_all(text,"아쉬운점","")
    text <- str_replace_all(text,"좋은점","")
    text <- str_replace_all(text,"1\r","")
    text <- str_replace_all(text,"2\r","")
    text <- str_replace_all(text,"\r\n","")
    text <- str_replace_all(text,"Byte\r\n","")
    text <- str_replace_all(text,"\r","")
    text <- str_replace_all(text,"Byte","")
    text <- str_replace_all(text,"text","")
  }
  
  all.text<-rbind(all.text,text)
  all.url<-c(all.url,url)
  if(length(all.url)==length(all.text)){
    break
  }
}

all.text<-str_replace_all(all.text,"text","")
write.csv(all.text,'SK4.csv')




all.text
all.url
