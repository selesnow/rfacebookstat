# rfacebookstat
# Пакет для загрузки данных из Marketing API Facebook в R.

##Содержание README

##Начало работы с API Facebook
Для начала работы с API Facebook необходимо создать приложение:
1. Перейдите в левое меню и в разделе «Разработчик» выберите команду «Управление приложениями».
<p align="center">
<img src="http://images.netpeak.net/blog/sozdajte-prilozenie-v-facebook.jpg" data-canonical-src="http://images.netpeak.net/blog/sozdajte-prilozenie-v-facebook.jpg" style="max-width:100%;">
</p>

2. В кабинете разработчика нажмите кнопку «+ Добавить новое приложение».
<p align="center">
<img src="http://images.netpeak.net/blog/dobavit-novoe-prilozenie.jpg" data-canonical-src="http://images.netpeak.net/blog/dobavit-novoe-prilozenie.jpg" style="max-width:100%;">
</p>
Заполните поля «Отображаемое название приложения»,«Эл. адрес для связи», «Категория» и нажмите «Создайте ID приложения».

3. Далее вы попадете в меню «Установка и настройка продукта». Кликните на кнопку «Начать» напротив пункта «Вход через Facebook».
<p align="center">
<img src="http://images.netpeak.net/blog/ustanovka-i-nastrojka-produkta.jpg" data-canonical-src="http://images.netpeak.net/blog/ustanovka-i-nastrojka-produkta.jpg" style="max-width:100%;">
</p>

4. Перейдите в настройки приложения. Во вкладке «Основное» находится информация по ID и секрету приложения, которая понадобится для работы с API.
<p align="center">
<img src="http://images.netpeak.net/blog/nastrojki-prilozenia-facebook.jpg" data-canonical-src="http://images.netpeak.net/blog/nastrojki-prilozenia-facebook.jpg" style="max-width:100%;">
</p>

На этой вкладке также заполните поля:
*«Отображаемое название»;
*«Домены приложений»;
*«Эл. адрес для связи»;
*«URL-адрес политики конфиденциальности»;
*«URL-адрес Пользовательского соглашения».

Можно указать произвольное название приложение, а остальные поля заполнить как на примере ниже.
<p align="center">
<img src="http://images.netpeak.net/blog/ukazat-proizvolnoe-nazvanie-prilozenie.jpg" data-canonical-src="http://images.netpeak.net/blog/ukazat-proizvolnoe-nazvanie-prilozenie.jpg" style="max-width:100%;">
</p>

5. В нижней части окна нажмите «Добавить платформу».
<p align="center">
<img src="http://images.netpeak.net/blog/dobavit-platformu.jpg" data-canonical-src="http://images.netpeak.net/blog/dobavit-platformu.jpg" style="max-width:100%;">
</p>

Из списка предложенных платформ выберите веб-сайт.
<p align="center">
<img src="http://images.netpeak.net/blog/vybor-platformy-dla-raboty-prilozenia-facebook.jpg" data-canonical-src="http://images.netpeak.net/blog/vybor-platformy-dla-raboty-prilozenia-facebook.jpg" style="max-width:100%;">
</p>

В поле «URL-адрес сайта» введите «https://github.com/selesnow/rfacebookstat» и нажмите «Сохранить изменения».
<p align="center">
<img src="http://images.netpeak.net/blog/v-pole-url-adres-sajta.png" data-canonical-src="http://images.netpeak.net/blog/v-pole-url-adres-sajta.png" style="max-width:100%;">
</p>

6. В меню приложения перейдите в раздел «Вход через Facebook». В поле «Действительные URL-адреса для перенаправления OAuth» введите «https://www.facebook.com/connect/login_success.html».
<p align="center">
<img src="http://images.netpeak.net/blog/dejstvitelnye-url-adresa-dla-perenapravlenia-oauth.jpg" data-canonical-src="http://images.netpeak.net/blog/dejstvitelnye-url-adresa-dla-perenapravlenia-oauth.jpg" style="max-width:100%;">
</p>

7. Далее нужно выбрать, из каких рекламных аккаунтов вы будете получать статистику через API и скопировать их ID (Чтобы получить ID аккаунта, перейдите в рекламный кабинет и скопируйте цифры из параметра act в URL.).
<p align="center">
<img src="http://images.netpeak.net/blog/id-reklamnogo-akkaunta-facebook.jpg" data-canonical-src="http://images.netpeak.net/blog/id-reklamnogo-akkaunta-facebook.jpg" style="max-width:100%;">
</p>

Перейдите в раздел «Настройки» —> «Дополнительно» и в блоке «Рекламные аккаунты» нажмите кнопку «API Ads».
<p align="center">
<img src="http://images.netpeak.net/blog/nazmite-knopku-api-ads.jpg" data-canonical-src="http://images.netpeak.net/blog/nazmite-knopku-api-ads.jpg" style="max-width:100%;">
</p>

В открывшемся окне введите ID выбранных рекламных аккаунтов.
<p align="center">
<img src="http://images.netpeak.net/blog/id-vybrannyh-reklamnyh-akkauntov.jpg" data-canonical-src="http://images.netpeak.net/blog/id-vybrannyh-reklamnyh-akkauntov.jpg" style="max-width:100%;">
</p>

На данном этапе вы получили уровень доступа к API «Development» и можете работать максимум с пятью рекламными аккаунтами.
*Если вам понадобится полный доступ к API, подробная инструкция находится [здесь](https://developers.facebook.com/docs/marketing-api/access/)*

##Функции пакета rfacebookstat

На данный момент в пакете rfacebookstat доступно 7 функций.
<table>
    <tr>
        <td><center>Функция</center></td><td><center>Описание</center></td>
    </tr>
    <tr>
        <td><center>fbGetToken</center></td><td><center>Получает окен для доступа к API Facebook</center></td>
    </tr>
     <tr>
        <td><center>fbGetLongTimeToken</center></td><td><center>Меняет краткосрочный на долгосрочный токен</center></td>
    </tr>
    <tr>
        <td><center>fbGetApps</center></td><td><center>Получает список рекламируемых приложений</center></td>
    </tr>
    <tr>
        <td><center>fbGetPages</center></td><td><center>Получает список рекламируемых страниц</center></td>
    </tr>
    <tr>
        <td><center>fbGetProjects</center></td><td><center>Получает список проектов доступных в бизнес менеджере</center></td>
    </tr>
    <tr>
        <td><center>fbGetAdAccounts</center></td><td><center>Получает список доступных рекламных аккаунтов</center></td>
    </tr>
    <tr>
        <td><center>fbGetMarketingStat</center></td><td><center>Получает статистику из рекламного кабинета</center></td>
    </tr>
</table>

##fbGetToken
###Описание
Функция предназначена для получения краткосрочного токена для доступа к API Facebook.

###Синтаксис
fbGetToken(app_id = 000000000)

###Аргументы
app_id - ID вашего приложени в Facebook

##fbGetLongTimeToken
###Описание
Данная функция меняет краткосрочный токен с сроком 2 часа на долгосрочный токен который действителен на протяжении двух месяцев.

###Синтаксис
fbGetLongTimeToken(client_id,client_secret,fb_exchange_token)

###Аругменты
client_id - ID вашего приложени в Facebook

client_secret - Секрет вашего приложения в Facebook 

fb_exchange_token - Значение краткосрочного токена полученного с помощью функции fbGetToken

##fbGetProjects
###Описание
Данная функция загружает список доступных в вашем бизнес менеджере проектов

###Синтаксис
fbGetProjects(bussiness_id, api_version, access_token)

###Аругменты
bussiness_id - ID вашего бизнес менеджера, посмотреть ID можно перейдя в основном меню бизнес менеджера в "Настройки Business Manager" на вкладку "Информация о компании".
<p align="center">
<img src="http://img.netpeak.ua/alsey/148190852785_kiss_43kb.png" data-canonical-src="http://img.netpeak.ua/alsey/148190852785_kiss_43kb.png" style="max-width:100%;">
</p>

api_version - Версия API Facebook в формате v*.*, например v2.8

access_token - Токен достепа полученный с помощью функции fbGetToken или fbGetLongTimeToken

##fbGetApps
###Описание
Данная функция возвращает набор данных со списком аккаунтов в вашем бизнес менеджере.

###Синтаксис
fbGetApps(projects_id, api_version, access_token)

###Аругменты
projects_id - ID проекта в котором ведётся реклама приложени

api_version - Версия API Facebook в формате v*.*, например v2.8

access_token - Токен достепа полученный с помощью функции fbGetToken или fbGetLongTimeToken

 *Автор пакета: Алексей Селезнёв, Head of Analytics Dept. at Netpeak*

 [GitHub](https://github.com/selesnow/)
 [VK](https://vk.com/selesnow)
 [Facebook](https://www.facebook.com/selesnow)
 [Linkedin](https://ua.linkedin.com/in/selesnow)
 [Stepik](https://stepik.org/users/792428)
  
<p align="center">
<img src="http://s017.radikal.ru/i444/1608/b7/989edcf88741.png" data-canonical-src="http://s017.radikal.ru/i444/1608/b7/989edcf88741.png" style="max-width:100%;">
</p>
