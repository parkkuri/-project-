# rmd가 추출되지 않아 R파일로 송부합니다.
# 페이지번호를 나누어 추출하였기 때문에 이 코드로 뽑히는 변수와 실제 데이터는 다릅니다.
# 이 코드를 실행하는 데는 조금 시간이 걸릴 수 있습니다.
# for문의 페이지 번호는 임의로 주면 제대로 데이터가 뽑히지 않기 때문에 
# 홈페이지의 실제 페이지번호를 확인하고 적정한 길이로 주었음을 밝힙니다.



library(XML) #패키지 설치
library(stringr) # 패키지 설치
library(rvest) # 패키지 설치

setwd("c:\\r_temp") #디렉토리 설정
getwd()

all.url<-c()
all.text  <- c()

urlall <- "http://www.jobkorea.co.kr/Starter/PassAssay/View/"  # url 앞부분 변수에 넣기
for(EEE in 144296:145579){ # 페이지번호를 돌려서 페이지를 추출, EEE가 페이지번호
  url <- paste(urlall,EEE,"?Page=1&OrderBy=0&FavorCo_Stat=0&Pass_An_Stat=0",sep="") #페이지 주소 전문이 되게 합치기
  jasoju <- read_html(url) # 페이지 소스 불러오기
  if(str_detect(jasoju,"선택하신 합격자소서 정보가 없습니다.")==T){ # 페이지가 없으면 next
    next
  }else{
    b<-html_nodes(jasoju, 'title') # 페이지 소스에서 <title>에 있는 코드 b로 넣기 
  } 
  if(str_detect(b,'현대')==F){  # <title>에 현대가 없으면 next, 있으면 추출
    next
  }else{
    tx <- html_nodes(jasoju, "span.tx") # <span class="tx"> 코드 안에 있는 글귀 tx 변수에 넣기 
    text <- html_text(tx[!str_detect(tx, "href")])  # <div class="tx"><a href (...)로 시작하는 코드에 있는 글귀 빼기
    text <- str_replace_all(text,"글자수","") # 자소서에 관련없는 단어 빼기
    text <- str_replace_all(text,"아쉬운점","") # 자소서에 관련없는 단어 빼기
    text <- str_replace_all(text,"좋은점","") # 자소서에 관련없는 단어 빼기
    text <- str_replace_all(text,"1\r","") # 자소서에 관련없는 단어 빼기
    text <- str_replace_all(text,"2\r","") # 자소서에 관련없는 단어 빼기
    text <- str_replace_all(text,"\r\n","") # 자소서에 관련없는 단어 빼기
    text <- str_replace_all(text,"Byte\r\n","") # 자소서에 관련없는 단어 빼기
    text <- str_replace_all(text,"\r","") # 자소서에 관련없는 단어 빼기
    text <- str_replace_all(text,"Byte","") # 자소서에 관련없는 단어 빼기
    text <- str_replace_all(text,"text","") # 자소서에 관련없는 단어 빼기
  }
  all.text<-rbind(all.text,text) # 자소서로 추출한 텍스트 all.text에 합치기
  all.url<-c(all.url,url) # url 합치기
}

all.text<-str_replace_all(all.text,"text","") # 자소서에 관련없는 단어 빼기
write.csv(all.text,'현대 질문.csv') # 디렉토리에 csv로 저장
 

