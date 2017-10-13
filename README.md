# rfacebookstat
# Пакет для загрузки данных из Marketing API Facebook в R.

## Содержание README
+ [Начало работы с API Facebook](https://github.com/selesnow/rfacebookstat/blob/master/README.md#Начало-работы-с-api-facebook)
+ [Устновка пакета]()
+ [Функции пакета rfacebookstat](https://github.com/selesnow/rfacebookstat/blob/master/README.md#Функции-пакета-rfacebookstat)
+ [fbGetToken](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgettoken) - Получить токен для работы с API Facebook.
+ [fbGetLongTimeToken](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgetlongtimetoken) - Заменяет краткорсочный токен на долгосрочный.
+ [fbGetBusinessManagers](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgetbusinessmanagers) - Загружает список доступных бизнес менеджеров
+ [fbGetAdAccountUsers] - Загружает список пользователей из рекламных аккаунтов
+ [fbGetProjects](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgetprojects) - Загружает список доступных в вашем бизнес менеджере проектов
+ [fbGetApps](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgetapps) - Загружает набор данных со списком аккаунтов в вашем бизнес менеджере.
+ [fbGetPages](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgetpages) - Возвращает список всех страниц по конкретному проекту бизнес менеджера.
+ [fbGetAdAccounts](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgetadaccounts) - Возвращает список всех рекламных аккаунтов по конкретному проекту бизнес менеджера.
+ [fbGetMarketingStat](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgetmarketingstat) - Основная функция пакета с помощью который вы можете получить статистику по своим рекламным аккаунтам.
+ [Пример работы с пакетом rfacebookstat](https://github.com/selesnow/rfacebookstat/blob/master/README.md#Пример-работы-с-пакетом-rfacebookstat)
+ [Об авторе пакета rfacebookstat](https://github.com/selesnow/rfacebookstat/blob/master/README.md#Автор-пакета-Алексей-Селезнёв-head-of-analytics-dept-at-netpeak)

## Начало работы с API Facebook
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

6. В меню приложения перейдите в раздел «Вход через Facebook». В поле «Действительные URL-адреса для перенаправления OAuth» введите «https://selesnow.github.io/rfacebookstat/getToken/get_token.html».
<p align="center">
<img src="http://img.netpeak.ua/alsey/150609735202_kiss_4kb.png" data-canonical-src="http://img.netpeak.ua/alsey/150609735202_kiss_4kb.png" style="max-width:100%;">
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

## Установка пакета rfacebookstat
Для установки пакета запустите приведённый ниже код в RStudio или R консоли.
```
if(!"devtools" %in% installed.packages()[,1]){install.packages("devtools")}
devtools::install_github('selesnow/rvkstat')
```

## Функции пакета rfacebookstat

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
        <td><center>fbGetBusinessManagers</center></td><td><center>Загружает список доступных бизнес менеджеров</center></td>
    </tr>
     <tr>
        <td><center>fbGetAdAccountUsers</center></td><td><center>Загружает список пользователей из рекламных аккаунтов</center></td>
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

## fbGetToken
### Описание
Функция предназначена для получения краткосрочного токена для доступа к API Facebook.

### Синтаксис
fbGetToken(app_id = 000000000)

### Аргументы
app_id - ID вашего приложени в Facebook

### Пример прохождения процесса аутентификации
MyFBToken <- fbGetToken(app_id = 1111111111111111)

После запуска приведённого выше кода при первом запуске функции наиболее вероятно что вы попадёте на страницу предупреждения:
 <p align="center"><img src="https://images.netpeak.net/blog/vy-popadete-na-stranicu-s-preduprezdeniem.jpg" data-canonical-src="https://images.netpeak.net/blog/vy-popadete-na-stranicu-s-preduprezdeniem.jpg" style="max-width:100%;"></p>
Пропустите это предупреждение с помощью кнопки «Продолжить как, ...».

Далее откроется окно в котором приложение запрос разрешение на доступ к данным.
<p align="center"><img src="https://images.netpeak.net/blog/podtverdite-vhod.jpg" data-canonical-src="https://images.netpeak.net/blog/podtverdite-vhod.jpg" style="max-width:100%;"></p>

После того как вы подтвердите доступ, нажав ОК вы попадаете на страницу https://selesnow.github.io/rfacebookstat/getToken/get_token.html, на которой будет сгенерирован токен доступа к API Facebook.
<p align="center"><img src="http://img.netpeak.ua/alsey/150609968097_kiss_70kb.png" data-canonical-src="http://img.netpeak.ua/alsey/150609968097_kiss_70kb.png" style="max-width:100%;"></p>

## fbGetLongTimeToken
### Описание
Данная функция меняет краткосрочный токен с сроком 2 часа на долгосрочный токен который действителен на протяжении двух месяцев.

### Синтаксис
fbGetLongTimeToken(client_id,client_secret,fb_exchange_token)

### Аругменты
client_id - ID вашего приложени в Facebook

client_secret - Секрет вашего приложения в Facebook 

fb_exchange_token - Значение краткосрочного токена полученного с помощью функции fbGetToken

## fbGetBusinessManagers
### Описание
Данная функция загружает список доступных бизнес менеджеров с некоторыми их параметрами.

### Синтаксис
fbGetBusinessManagers(api_version = "v2.10", access_token = NULL)

### Аругменты
api_version - Версия API Facebook в формате v*.*, например v2.10

access_token - Токен достепа полученный с помощью функции fbGetToken или fbGetLongTimeTokenn

## fbGetAdAccountUsers
### Описание
Данная функция загружает список пользователей рекламных аккаунтов.

### Синтаксис
fbGetAdAccountUsers(accounts_id = NULL ,api_version = "v2.10", access_token = NULL)

### Аругменты
accounts_id - Вектор ID рекламных аккаунтов с префиксом act_, получить список всех доступны рекламных аккаунтов можно с помощью функции `fbGetAdAccounts`

api_version - Версия API Facebook в формате v*.*, например v2.10

access_token - Токен достепа полученный с помощью функции fbGetToken или fbGetLongTimeTokenn

## fbGetProjects
### Описание
Данная функция загружает список доступных в вашем бизнес менеджере проектов

### Синтаксис
fbGetProjects(bussiness_id, api_version, access_token)

### Аругменты
bussiness_id - ID вашего бизнес менеджера, посмотреть ID можно перейдя в основном меню бизнес менеджера в "Настройки Business Manager" на вкладку "Информация о компании".
<p align="center">
<img src="http://img.netpeak.ua/alsey/148190852785_kiss_43kb.png" data-canonical-src="http://img.netpeak.ua/alsey/148190852785_kiss_43kb.png" style="max-width:100%;">
</p>

api_version - Версия API Facebook в формате v*.*, например v2.8

access_token - Токен достепа полученный с помощью функции fbGetToken или fbGetLongTimeToken

## fbGetApps
### Описание
Данная функция возвращает набор данных со списком аккаунтов в вашем бизнес менеджере.

### Синтаксис
fbGetApps(projects_id, api_version, access_token)

### Аругменты
projects_id - ID проекта в котором ведётся реклама приложени, список ID всех доступных вам проектов можно получить с помощью функции fbGetProjects

api_version - Версия API Facebook в формате v*.*, например v2.8

access_token - Токен достепа полученный с помощью функции fbGetToken или fbGetLongTimeToken

## fbGetPages
### Описание
Функция возвращает список всех страниц по конкретному проекту бизнес менеджера.

### Синтаксис
fbGetPages(projects_id, api_version, access_token)

### Аругменты
projects_id - ID проекта в котором ведётся реклама приложени, список ID всех доступных вам проектов можно получить с помощью функции fbGetProjects

api_version - Версия API Facebook в формате v*.*, например v2.8

access_token - Токен достепа полученный с помощью функции fbGetToken или fbGetLongTimeToken

## fbGetAdAccounts
### Описание
Функция возвращает список всех рекламных аккаунтов по конкретному проекту бизнес менеджера.

### Синтаксис
fbGetAdAccounts(source_id, api_version, access_token )

### Аругменты
source_id - ID проекта или бизнес менеджера в котором ведётся реклама приложени, список ID всех доступных вам проектов можно получить с помощью функции fbGetProjects, если не указать никакое значение в аргументе source_id функция вернёт список всех доступных вам рекламных аккаунтов.

api_version - Версия API Facebook в формате v*.*, например v2.8

access_token - Токен достепа полученный с помощью функции fbGetToken или fbGetLongTimeToken

## fbGetMarketingStat
### Описание
Основная функция пакета с помощью который вы можете получить статистику по своим рекламным аккаунтам.

### Синтаксис
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

### Аругменты
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

## Пример работы с пакетом rfacebookstat

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
                                                       
## Автор пакета: Алексей Селезнёв, Head of Analytics Dept. at Netpeak

<center>
<table>
<tr>
<td>
<img src="https://lh3.googleusercontent.com/R-0jgJSxIIhpag2L6YCIhJVIcIWx6-Jt5UCTRJjWzJewo47u2QBnik5CRF2dNB79jmsN_BFRjVOAYfvCqFcn3UNS_thGbbxF-99c9lwBWWlFI7JCWE43K5Yk9HnIW8i8YpTDx3l28IuYswaI-qc9QosHT1lPCsVilTfXTyV2empF4S74daOJ6x5QHYRWumT_2MhUS0hPqUsKVtOoveqDnGf3cF_VsN-RfOAwG9uCeGOgNRgv_fhSr41rw4LBND4gf05nO8zMp4TZMrrcUjKvvx6qNgYDor5LFOHiRmfKISYRVkWYe4wLyGO1FgkgTDjg0300lcur2t3txVwZUgROLZdaxOLx4owa8Rc8B8VKwd3vHxjov_aVfNPT4xf9jSFBBEOI-mfYpa55ejKDw-rqTQ6miFRFWpp_hjrk9KbGyB-Z6iZvYL-2dZ6mzgpUfs2I0tEAGsV07yTzboJ0RNCByC2-U-ZVjWdp2_9Au3FFoUcdQUAmPYOVqOv4r3oLbkkJKLj2A5jp7vf4IAoExLIfJuqEf7XN7fFcv4geib029qJjBt28wnqSO6TKEwB2fesR3uPHvGB6_6NHD70UDH-aCRCK4UBeoajtU0Y8Ks8Vwxo0oZBwmoEu8gudTFBF6mDT7GjLoGLDeNxE-TG7OtWUdxsJk7yzXGW3hE-VxsMD9g=s351-no?w=300" data-canonical-src="https://alexeyseleznev.files.wordpress.com/2017/03/as.png?w=300" style="max-width:100%;">
</td>
<td>
Контакты:
<nav class="jetpack-social-navigation jetpack-social-navigation-svg">
<ul id="menu-%d1%81%d0%be%d1%86%d0%b8%d0%b0%d0%bb%d1%8c%d0%bd%d1%8b%d0%b5-%d1%81%d0%b5%d1%82%d0%b8" class="menu">
<li id="menu-item-13" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-13"><a href="http://www.facebook.com/selesnow" target="_blank"><span class="screen-reader-text">Facebook</span></a></li>
<li id="menu-item-14" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-14"><a href="https://www.linkedin.com/in/selesnow/" target="_blank"><span class="screen-reader-text">LinkedIn</span></a></li>
<li id="menu-item-15" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-15"><a href="http://www.vk.com/selesnow" target="_blank"><span class="screen-reader-text">Vkontakte</span></a></li>
<li id="menu-item-16" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-16"><a href="https://github.com/selesnow"><span class="screen-reader-text">GitHub</span></a></li>
<li class="menu-item menu-item-type-custom menu-item-object-custom menu-item-16"><a href="https://alexeyseleznev.wordpress.com/">Blog</a></li>
</ul>
</nav>
</td>
</tr>
</table>
</center>
  
<p align="center">
<img src="https://alexeyseleznev.files.wordpress.com/2017/03/as.png?w=300" data-canonical-src="https://alexeyseleznev.files.wordpress.com/2017/03/as.png?w=300" style="max-width:100%;">
</p>
