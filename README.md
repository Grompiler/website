## To start the website

>systemctl start docker  
>docker build -t website .  
>docker run -d --net=host --rm --name website_container website  

## Then

>docker stop website_container  
