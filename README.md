# rfacebookstat
# Пакет для загрузки данных из Marketing API Facebook в R.

##Содержание README
+ [Начало работы с API Facebook](https://github.com/selesnow/rfacebookstat/blob/master/README.md#Начало-работы-с-api-facebook)
+ [Функции пакета rfacebookstat](https://github.com/selesnow/rfacebookstat/blob/master/README.md#Функции-пакета-rfacebookstat)
+ [fbGetToken](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgettoken)
+ [fbGetLongTimeToken](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgetlongtimetoken)
+ [fbGetProjects](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgetprojects)
+ [fbGetApps](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgetapps)
+ [fbGetPages](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgetpages)
+ [fbGetAdAccounts](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgetadaccounts)
+ [fbGetMarketingStat](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgetmarketingstat)
+ [Пример работы с пакетом rfacebookstat](https://github.com/selesnow/rfacebookstat/blob/master/README.md#Пример-работы-с-пакетом-rfacebookstat)

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
+ «Отображаемое название»;
+ «Домены приложений»;
+ «Эл. адрес для связи»;
+ «URL-адрес политики конфиденциальности»;
+ «URL-адрес Пользовательского соглашения».

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
projects_id - ID проекта в котором ведётся реклама приложени, список ID всех доступных вам проектов можно получить с помощью функции fbGetProjects

api_version - Версия API Facebook в формате v*.*, например v2.8

access_token - Токен достепа полученный с помощью функции fbGetToken или fbGetLongTimeToken

##fbGetPages
###Описание
Функция возвращает список всех страниц по конкретному проекту бизнес менеджера.

###Синтаксис
fbGetPages(projects_id, api_version, access_token)

###Аругменты
projects_id - ID проекта в котором ведётся реклама приложени, список ID всех доступных вам проектов можно получить с помощью функции fbGetProjects

api_version - Версия API Facebook в формате v*.*, например v2.8

access_token - Токен достепа полученный с помощью функции fbGetToken или fbGetLongTimeToken

##fbGetAdAccounts
###Описание
Функция возвращает список всех рекламных аккаунтов по конкретному проекту бизнес менеджера.

###Синтаксис
fbGetAdAccounts(projects_id, api_version, access_token )

###Аругменты
projects_id - ID проекта в котором ведётся реклама приложени, список ID всех доступных вам проектов можно получить с помощью функции fbGetProjects

api_version - Версия API Facebook в формате v*.*, например v2.8

access_token - Токен достепа полученный с помощью функции fbGetToken или fbGetLongTimeToken

##fbGetMarketingStat
###Описание
Основная функция пакета с помощью который вы можете получить статистику по своим рекламным аккаунтам.

###Синтаксис
fbGetMarketingStat(accounts_id, 
                   sortingL, 
                   level, 
                   breakdowns, 
                   fields, 
                   filtering, 
                   date_start, 
                   date_stop, 
                   api_version,
                   access_token)

###Аругменты
accounts_id — ID рекламного аккаунта. Это обязательный аргумент. Вы можете получить его из URL, если перейдете в нужный рекламный аккаунт Facebook, указывайте ID аккаунта с приставкой «act_», как в примере: accounts_id = "act_000000000000".

sorting — cортировка данных. Необязательный аргумент. На входе принимает список полей и направление сортировки (по возрастанию или по убыванию). Пример: reach_descending, impressions_ascending.

level — уровень детализации данных. Обязательный аргумент. Принимает значения ad, adset, campaign, account. Пример — level = "account".

fields — список полей, по которым вы планируете получить данные. Обязательный аргумент. Пример: fields = "account_id,account_name,campaign_name,impressions,unique_impressions,clicks,unique_clicks,reach,spend". Актуальный список всех доступных полей можно посмотреть в официальной документации к API по [ссылке](https://developers.facebook.com/docs/marketing-api/insights/fields/).

filtering — фильтр данных. Необязательный аргумент. Фильтры задаются в виде JSON объектов «ключ:значение». Необходимо прописать три свойства:

+ field — поле, по которому будет осуществляться фильтрация;
+ operator — оператор логического значения ('EQUAL', 'NOT_EQUAL', 'GREATER_THAN', 'GREATER_THAN_OR_EQUAL', 'LESS_THAN', 'LESS_THAN_OR_EQUAL', 'IN_RANGE', 'NOT_IN_RANGE', 'CONTAIN', 'NOT_CONTAIN', 'IN', 'NOT_IN', 'ANY', 'ALL', 'NONE');
+ value — значения, по которому будет фильтроваться указанное поле.
Пример: filtering = "[{'field':'publisher_platform','operator':'IN','value':['instagram']}]

breakdowns — аргумент, с помощью которого можно получить данные в разбивке на различные сегменты. Список доступных срезов информации, а так же информацию о том как они могут друг с другом сочитаться можно посмотреть в официальной документации к API по [ссылке](https://developers.facebook.com/docs/marketing-api/insights/breakdowns/).

date_start — начальная дата отчетного периода в формате YYYY-MM-DDD.

date_stop — конечная дата отчетного периода в формате YYYY-MM-DDD.

api_version — версия API Facebook, в формате v*.*, например "v2.8"

access_token — токен доступа.

##Пример работы с пакетом rfacebookstat

Перед тем как запускать описанные ниже примеры, необходимо получить API-токен и сохраните его в объект token.
`token <- fbGetToken(app_id = 00000000000000)`

Чтобы получить статистику о количестве показов, кликов и затрат на рекламу на уровне аккаунта и в  разрезе регионов, введите следующий код:

```
AccStat <- fbGetMarketingStat(accounts_id = «act_0000000000»,
                              level = "account",
                              fields = "account_id,account_name,impressions,clicks,spend",
                              breakdowns = "region",
                              date_start = "2016-11-01",
                              date_stop = "2016-11-30",
                              api_version = "v2.8",
                              access_token = token)
```

Получите статистику по количеству уникальных показов и уникальных кликов, с фильтром по возрастным группам «18-24», «25-34» и сортировкой данных в порядке убывания количества уникальных показов (поле unique_impressions).


```
CampStat <-     fbGetMarketingStat(accounts_id = "act_0000000000",
                                   level = "campaign",
                                   fields = "campaign_name,unique_impressions,unique_clicks",
                                   breakdowns = "age",
                                   sorting = "unique_impressions_descending",
                                   filtering = "[{'field':'age','operator':'IN','value':['18-24','25-34']}]",
                                   date_start = "2016-10-01",
                                   date_stop = "2016-10-10",
                                   api_version = "v2.8",
                                   access_token = token)
```
                                                       
 *Автор пакета: Алексей Селезнёв, Head of Analytics Dept. at Netpeak*

 [GitHub](https://github.com/selesnow/)
 [VK](https://vk.com/selesnow)
 [Facebook](https://www.facebook.com/selesnow)
 [Linkedin](https://ua.linkedin.com/in/selesnow)
 [Stepik](https://stepik.org/users/792428)
  
<p align="center">
<img src="http://s017.radikal.ru/i444/1608/b7/989edcf88741.png" data-canonical-src="http://s017.radikal.ru/i444/1608/b7/989edcf88741.png" style="max-width:100%;">
</p>
