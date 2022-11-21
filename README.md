## To start the website

>systemctl start docker  
>docker build -t website .  

>docker run -d -p7878:7878 --rm --name website_container website  
or
>docker run -d --net=host --rm --name website_container website  

## Then

>docker stop website_container  
