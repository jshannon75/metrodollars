#Ladder plot for mixed metro classifications

library(tidyverse)

term_names<-read_csv("data/term_names.csv") %>%
  mutate(title=factor(title,levels=title))

alldata_model<-read_csv("data/modeldata.csv")

store_pal<-c("#303133","#e8ba14","#62B33C","#EE3124","#9162da","#752314")
mmclasses<-c("White, low diversity","White, moderate diversity","Latino, low diversity",
             "Latino, moderate diversity","Black, low diversity","Black, moderate diversity",
             "Asian, moderate diversity","High diversity")

plotdata<-alldata_model %>%
  select(year,class_mm_char,Supermarket,Grocer,wdist_km,store) %>%
  distinct() %>%
  spread(store,wdist_km) %>%
  filter(year %in% c("Y2011","Y2015")) %>%
  gather(Supermarket:`Family Dollar`,key="store",value="dist") %>%
  filter(is.na(dist)==FALSE) %>%
  group_by(year,class_mm_char,store) %>%
  summarise(dist=median(dist))

names(plotdata)

ggplot(plotdata,aes(x=year,y=dist,group=store))+
  geom_line(data=plotdata %>% filter(!store %in% c("Grocer","Supermarket")),
            aes(x=year,y=dist,color=store),size=1,alpha=0.7,linetype=1)+
  geom_line(data=plotdata %>% filter(store %in% c("Grocer","Supermarket")),
            aes(x=year,y=dist,color=store),linetype=2)+
  geom_point(aes(x=year,y=dist,color=store)) +
  scale_colour_manual(values=store_pal,name="")+
  facet_wrap(~class_mm_char,nrow=2) +
  theme_minimal()+
  theme( # remove the vertical grid lines
    panel.grid.minor.y = element_blank() ,
    # explicitly set the horizontal lines (or they will disappear too)
     panel.grid.major.x = element_line( size=.1, color="black" ),
    legend.position="bottom"
  ) +
  ylab("Distance to nearest location (miles)")+xlab("")

ggsave("graphics/storeplot_dist.pdf",width=13,height=6,units="in")
ggsave("graphics/storeplot_dist.png",width=13,height=6,units="in")

plotdata1<-plotdata %>%
  filter(str_detect(class_mm_char,"Asian, low diversity|Asian, moderate diversity|Black, low diversity|Black, moderate diversity|High diversity|Latino, low diversity|Latino, moderate diversity|White, low diversity|White, moderate diversity")==TRUE) %>%
  mutate(class_mm_char1=as.character(class_mm_char))

ggplot(plotdata1,aes(x=year,y=dist,group=store))+
  geom_line(data=plotdata1 %>% filter(!store %in% c("Grocer","Supermarket")),
            aes(x=year,y=dist,color=store),size=1,alpha=0.7,linetype=1)+
  geom_line(data=plotdata1 %>% filter(store %in% c("Grocer","Supermarket")),
            aes(x=year,y=dist,color=store),linetype=2)+
  geom_point(aes(x=year,y=dist,color=store)) +
  scale_colour_manual(values=store_pal,name="")+
  facet_wrap(~class_mm_char,nrow=2) +
  theme_minimal()+
  theme( # remove the vertical grid lines
    panel.grid.minor.y = element_blank() ,
    # explicitly set the horizontal lines (or they will disappear too)
    panel.grid.major.x = element_line( size=.1, color="black" ),
    legend.position="bottom",
    strip.text = element_text(size = 11),
    strip.background=element_blank()
  ) +
  ylab("Distance to nearest location (miles)")+xlab("")
ggsave("graphics/storeplot_dist1.pdf",width=9,height=6,units="in")
ggsave("graphics/storeplot_dist1.png",width=9,height=6,units="in")

#Table version
plotdata_table<-plotdata %>%
  spread(year,dist) %>%
  arrange(store)

write_csv(plotdata_table,"data/store_meddist.csv")
