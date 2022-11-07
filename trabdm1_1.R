url <- 'http://www-usr.inf.ufsm.br/~joaquim/UFSM/DM/ds/_ASSOC_BGFriends_01.csv'
url1 <- 'http://www-usr.inf.ufsm.br/~joaquim/UFSM/DM/ds/_ASSOC_BGFriends_02.csv'

install.packages("tidyr")
library("tidyr")

install.packages("readr")
library("readr")

df <- read.csv(url, fileEncoding = "UTF-8")  
df1 <- read.csv(url1, fileEncoding = "ISO-8859-9")

df2=rbind(df,df1)

vitoria=replicate(153,0)      #cria vetor de zeros

df2=cbind(df2,vitoria)


for(i in 1:153){      #preenche a coluna "vitoria" com 1 no caso de amigos>oponentes
  res=df2$Oponentes[i]-df2$Amigos[i]
  if(res<0){
    df2$vitoria[i]=df2$vitoria+1      
  }
}

df2=df2[,-3:-4]     #retira as colunas 3 e 4

df2=df2 %>% separate(Jogadore.a.s, c("j1","j2","j3"),",")     #divide as coluna jogadores em três

df2=as.data.frame(apply(df2,2,function(x)gsub("\\s+","",x)))      #retira espaços  

for(i in 1:153){      #uppercase nas iniciais
  df2$j1[i]=str_to_title(df2$j1[i])
  df2$j2[i]=str_to_title(df2$j2[i])
  df2$j3[i]=str_to_title(df2$j3[i])
}

df2$j1=sub("Francois","François", df2$j1)
df2$j2=sub("Francois","François", df2$j2)
df2$j3=sub("Francois","François", df2$j3)


write.csv(df2,"/home/visitante/Documentos/csvR/data.csv")     #exporta scrip como .cvs
