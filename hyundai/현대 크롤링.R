# rmd가 추출되지 않아 R파일로 송부합니다.
# 페이지번호를 나누어 추출하였기 때문에 이 코드로 뽑히는 변수와 실제 데이터는 다릅니다.
# 이 코드를 실행하는 데는 조금 시간이 걸릴 수 있습니다.
# for문의 페이지 번호는 임의로 주면 제대로 데이터가 뽑히지 않기 때문에 
# 홈페이지의 실제 페이지번호를 확인하고 적정한 길이로 주었음을 밝힙니다.


library(XML)
library(stringr)
library(rvest)

setwd("c:\\r_temp") 
getwd()

all.url<-c()
all.text  <- c()

urlall <- "http://www.jobkorea.co.kr/Starter/PassAssay/View/"
for(EEE in 145438:147042){
  url <- paste(urlall,EEE,"?Page=1&OrderBy=0&FavorCo_Stat=0&Pass_An_Stat=0",sep="")
  jasoju <- read_html(url)
  if(str_detect(jasoju,"선택하신 합격자소서 정보가 없습니다.")==T){
    next
  }else{
    b<-html_nodes(jasoju, 'title')
  } 
  if(str_detect(b,'현대')==F){
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
}

all.text<-str_replace_all(all.text,"text","")
write.csv(all.text,'현대.csv')

