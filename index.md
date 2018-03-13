<head>
<link rel="shortcut icon" type="image/x-icon" href="as.ico">
    
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-114798296-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'UA-114798296-1');
</script>

</head>

<p align="center">
<a href="https://selesnow.github.io/"><img src="https://alexeyseleznev.files.wordpress.com/2017/03/as.png" height="80"></a>
</p>

<table>
    <tr>
      <td>
        <a href="https://selesnow.github.io/ryandexdirect/">ryandexdirect</a>
      </td>
      <td>
        <a href="https://selesnow.github.io/rfacebookstat/">rfacebookstat</a>
      </td>
      <td>
        <a href="https://selesnow.github.io/rvkstat/">rvkstat</a>
      </td>
      <td>
        <a href="https://selesnow.github.io/rmytarget/">rmytarget</a>
      </td>
      <td>
        <a href="https://selesnow.github.io/rmixpanel/">rmixpanel</a>
      </td>
      <td>
        <a href="https://selesnow.github.io/getProxy/">getProxy</a>
      </td>
      <td>
        <a href="https://selesnow.github.io/rGitHub/">rGitHub</a>
      </td>
      <td>
        <a href="https://selesnow.github.io/news/">NEWS</a>
      </td>
    </tr>
</table>

<script>
  (function() {
    var cx = '002735389418227325972:fdikniadyig';
    var gcse = document.createElement('script');
    gcse.type = 'text/javascript';
    gcse.async = true;
    gcse.src = 'https://cse.google.com/cse.js?cx=' + cx;
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(gcse, s);
  })();
</script>
<gcse:search></gcse:search>

# rfacebookstat
# Пакет для загрузки данных из Marketing API Facebook в R.

## Содержание README
+ [Начало работы с API Facebook](https://github.com/selesnow/rfacebookstat/blob/master/README.md#Начало-работы-с-api-facebook)
+ [Устновка пакета](https://github.com/selesnow/rfacebookstat/blob/master/README.md#Установка-пакета-rfacebookstat)
+ [Функции пакета rfacebookstat](https://github.com/selesnow/rfacebookstat/blob/master/README.md#Функции-пакета-rfacebookstat)
    + [fbGetToken](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgettoken) - Получить токен для работы с API Facebook.
    + [fbGetLongTimeToken](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgetlongtimetoken) - Заменяет краткорсочный токен на долгосрочный.
    + [fbGetBusinessManagers](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgetbusinessmanagers) - Загружает список доступных бизнес менеджеров
    + [fbGetAdAccountUsers](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgetadaccountusers) - Загружает список пользователей из рекламных аккаунтов
    + [fbGetAdAccountUsersPermissions](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbgetadaccountuserspermissions) - Загружает список пользователей с их привилегиями и ролью для рекламного аккаунта.
    + [fbUpdateAdAccountUsers](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbupdateadaccountusers) - Добавить пользователей в рекламные аккаунты на Facebook.
    + [fbDeleteAdAccountUsers](https://github.com/selesnow/rfacebookstat/blob/master/README.md#fbdeleteadaccountusers) - Удалить пользователей из рекламных аккаунтов в Facebook.
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
devtools::install_github('selesnow/rfacebookstat')
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
        <td><center>fbGetAdAccountUsersPermissions</center></td><td><center>Загружает список пользователей из рекламных аккаунтов с их привилегиями и ролью, по смыслу очень схожа с fbGetAdAccountUsers</center></td>
    </tr>
    <tr>
        <td><center>fbUpdateAdAccountUsers</center></td><td><center>Добавить пользователей в рекламные аккаунты Facebook</center></td>
    </tr>
     <tr>
        <td><center>fbDeleteAdAccountUsers</center></td><td><center>Удалить пользователей из рекламных аккаутов в Facebook</center></td>
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

console_type - тип ответов в консоли, принимает одно из двух значений:
    + "progressbar" (по умолчанию) - для вывода в консоли прогресс бара, отображающего % загруженных даных.
    + "message" - для вывода информационных сообщений о процессе загрузки, например вывод сообщений о том, какой аккаунт обрабатывается, и сколько пользователей по нему загружено.

access_token - Токен достепа полученный с помощью функции fbGetToken или fbGetLongTimeToken

## fbGetAdAccountUsersPermissions
### Описание
Данная функция загружает список пользователей рекламных аккаунтов с их привилегиями и ролью.

**Расшифровка привилегий:**
<br>1: ACCOUNT_ADMIN: Имеет права на изменение списка пользователей рекламного аккаунта и привелегий пользователей.
<br>2: ADMANAGER_READ: Имеет права просмотра рекламных кампаний и объявлений.
<br>3: ADMANAGER_WRITE:  Имеет права вносить изменения в рекламные аккаунты.
<br>4: BILLING_READ: Право просмотра информации о платежах
<br>5: BILLING_WRITE: Права внесения изменений в платёжные данные
<br>7: REPORTS: Просмотр отчётов
<br>9, 10 - Право подать заявку на некоторые управляемые аккаунты. В настоящее время не требуется для вызовов API маркетинга.

**Расшифровка роли**
<br>1001 = Администратор
<br>1002 = Рекламодатель
<br>1003 = Аналитик
<br>1004 = Прямой доступ к продажам. Для ограниченных управляемых учетных записей.

### Синтаксис
fbUpdateAdAccountUsers(accounts_id = NULL ,api_version = "v2.12", access_token = NULL)

### Аругменты
accounts_id - Вектор ID рекламных аккаунтов с префиксом act_, получить список всех доступны рекламных аккаунтов можно с помощью функции `fbGetAdAccounts`

api_version - Версия API Facebook в формате v*.*, например v2.10

console_type - тип ответов в консоли, принимает одно из двух значений:
+ "progressbar" (по умолчанию) - для вывода в консоли прогресс бара, отображающего % загруженных даных.
+ "message" - для вывода информационных сообщений о процессе загрузки, например вывод сообщений о том, какой аккаунт обрабатывается, и сколько пользователей по нему загружено.

access_token - Токен достепа полученный с помощью функции fbGetToken или fbGetLongTimeToken

## fbUpdateAdAccountUsers
### Описание
Добавляет пользователей в рекламные аккаунты Facebook с определённым набором прав.
Для того, что бы добавить пользователей в аккаунт вы должны быть админисратором данного аккаунта.

### Синтаксис
fbUpdateAdAccountUsers(user_ids = NULL, 
                       role = "advertiser", 
                       accounts_id = NULL,
                       api_version = "v2.12",
                       access_token = NULL)

### Аругменты
user_ids - Вектор ID пользователей коорых вы хотите добавить в рекламные аккаунты.

accounts_id - Вектор ID рекламных аккаунтов с префиксом act_ в которые вы хотите добавить пользователей, получить список всех доступны рекламных аккаунтов можно с помощью функции `fbGetAdAccounts`

api_version - Версия API Facebook в формате v*.*, например v2.10

role - Роль пользователя который будет добалвен в аккаунт, каждая роль имеет свой набор привилегий, допустимые значения:
+ "administator"- Пользователь будет обладать максимальным доступом и будет иметь право добавлять и удалять пользователей рекламного аккаунта.
+ "advertiser" (по умолчанию) - Пользователь будет иметь право вносить изменения в рекламные кампании аккаунта.
+ "ad manager" - Пользователь будет иметь право вносить изменения в рекламные кампании аккаунта.
+ "analyst" - Пользователь будет иметь доступ к статистике рекламного аккаунта, без возможности внесения правок в рекламные кампании и аккаунт.
+ "sales" - Пользователь будет иметь ограниченый досуп на управление рекламным аккаунтом.
+ "direct sales" - Пользователь будет иметь ограниченый досуп на управление рекламным аккаунтом.

access_token - Токен достепа полученный с помощью функции fbGetToken или fbGetLongTimeToken

## fbDeleteAdAccountUsers
### Описание
Удаляет пользователей из рекламных аккаунтов Facebook с определённым набором прав.
Для того, что бы удалить пользователей из аккаунта вы должны быть админисратором данного аккаунта.

### Синтаксис
fbDeleteAdAccountUsers(user_ids = NULL, 
                       accounts_id = NULL,
                       api_version = "v2.12",
                       access_token = NULL)

### Аругменты
user_ids - Вектор ID пользователей которых вы хотите удалить из рекламные аккаунты.

accounts_id - Вектор ID рекламных аккаунтов с префиксом act_ из которых вы хотите удалить пользователей, получить список всех доступны рекламных аккаунтов можно с помощью функции `fbGetAdAccounts`

api_version - Версия API Facebook в формате v*.*, например v2.12

access_token - Токен достепа полученный с помощью функции fbGetToken или fbGetLongTimeToken

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

console_type - тип ответов в консоли, принимает одно из двух значений:
* progressbar (по умолчанию) - для вывода в консоли прогресс бара, отображающего % загруженных даных.
* message - для вывода сообщений о процессе загрузки, например вывод сообщений о том, какой аккаунт в данный момент обрабатывается, и о том сколько пользователей по каждому из аккаунтов найдено.
    
access_token - Токен достепа полученный с помощью функции fbGetToken или fbGetLongTimeToken

### Структура возвращаемого дата фрейма
<table>
    <tr>
        <td><center>Поле</center></td><td><center>Описание</center></td>
    </tr>
    <tr>
        <td><center>name</center></td><td><center>Имя учетной записи. Если имя учетной записи не установлено, будет возвращено имя первого администратора, видимого пользователю.</center></td>
    </tr>
     <tr>
        <td><center>id</center></td><td><center>ID рекламного аккаунта с префиксом "act_"</center></td>
    </tr>
     <tr>
        <td><center>account_id</center></td><td><center>ЗID рекламного аккаунта</center></td>
    </tr>
     <tr>
        <td><center>account_status</center></td><td><center>Статус аккаунта, возможные значения 1 = ACTIVE, 2 = DISABLED, 3 = UNSETTLED, 7 = PENDING_RISK_REVIEW, 9 = IN_GRACE_PERIOD, 100 = PENDING_CLOSURE, 101 = CLOSED, 102 = PENDING_SETTLEMENT, 201 = ANY_ACTIVE, 202 = ANY_CLOSED
</center></td>
    </tr>
    <tr>
        <td><center>amount_spent</center></td><td><center>Сумма потраченных средств, этот параметр можно сбрасывать в настройках аккаунта</center></td>
    </tr>
    <tr>
        <td><center>balance</center></td><td><center>Остаток средств аккаунта</center></td>
    </tr>
    <tr>
        <td><center>currency</center></td><td><center>Валюта аккаунта</center></td>
    </tr>
    <tr>
        <td><center>business_city</center></td><td><center>Город указанный в настройках бизнес менеджера</center></td>
    </tr>
    <tr>
        <td><center>business_country_code</center></td><td><center>Страна указанная в настройках бизнес менеджера</center></td>
    </tr>
    <tr>
        <td><center>age</center></td><td><center>Количество дней после активации рекламного аккаунта</center></td>
    </tr>
    <tr>
        <td><center>spend_cap</center></td><td><center>Лимит средств который может быть потрачен в рекламном аккаунта, после чего рекламные кампании будут остановлены, если установлено значения 0 то лимита нет.</center></td>
    </tr>
    </tr>
    <tr>
        <td><center>business.id</center></td><td><center>ID бизнес менеджера к которому приклеплён аккаунт</center></td>
    </tr>
    <tr>
        <td><center>business.name</center></td><td><center>Название бизнес менеджера к которому приклеплён аккаунт</center></td>
    </tr>
    <tr>
        <td><center>owner.id</center></td><td><center>ID владельца рекламного аккаунта</center></td>
    </tr>
    <tr>
        <td><center>owner.name</center></td><td><center>Имя владельца рекламного аккаунта</center></td>
    </tr>
</table>

## fbGetMarketingStat
### Описание
Основная функция пакета с помощью который вы можете получить статистику по своим рекламным аккаунтам.

### Синтаксис
fbGetMarketingStat(accounts_id, 
                   sorting, 
                   level, 
                   breakdowns, 
                   action_breakdowns,
                   fields, 
                   filtering, 
                   date_start, 
                   date_stop, 
                   interval,
                   console_type,
                   request_speed,
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

interval - временная разбивка, допустимые значения "day", "week", "month", "quarter", "year", "overall"

console_type - текстовое значение, тип ответов в консоли, принимает одно из двух значений:
* progressbar (по умолчанию) - для вывода в консоли прогресс бара, отображающего % загруженных даных.
* message - для вывода сообщений о процессе загрузки, например вывод сообщений о том, что был запущен механизм обхода пользовательского лимита на количество допустимых запросов к API Facebook.

request_speed - скорость оправки запросов к API, в зависимости от уровня доступа вашего приложения установите следующее значение:
* Уровень доступа к API Development - "slow"
* Уровень доступа к API Basic - "normal"
* Уровень доступа к API Standart - "fast"
Подробно работа с этим аргументом описана [тут](https://alexeyseleznev.wordpress.com/2017/12/26/rfacebookstat-1-5-0-%D0%BA%D0%B0%D0%BA-%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D0%BB%D1%8C%D0%BD%D0%BE-%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D1%82%D1%8C-%D0%B0%D1%80%D0%B3%D1%83%D0%BC/).
Информация об уровнях доступа к API Facebook находится [тут](https://developers.facebook.com/docs/marketing-api/access).

api_version — версия API Facebook, в формате v*.*, например "v2.11"

access_token — токен доступа.

## Пример работы с пакетом rfacebookstat

Перед тем как запускать описанные ниже примеры, необходимо получить API-токен и сохраните его в объект token.
`token <- fbGetToken(app_id = 00000000000000)`

Чтобы получить статистику о количестве показов, кликов и затрат на рекламу на уровне аккаунта и в  разрезе регионов, введите следующий код:

```r
AccStat <- fbGetMarketingStat(accounts_id = «act_0000000000»,
                              level = "account",
                              fields = "account_id,account_name,impressions,clicks,spend",
                              breakdowns = "region",
                              date_start = "2016-11-01",
                              date_stop = "2016-11-30",
                              access_token = token)
```

Получите статистику по количеству уникальных показов и уникальных кликов, с фильтром по возрастным группам «18-24», «25-34» и сортировкой данных в порядке убывания количества уникальных показов (поле unique_impressions).


```r
CampStat <-     fbGetMarketingStat(accounts_id = "act_0000000000",
                                   level = "campaign",
                                   fields = "campaign_name,impressions,clicks",
                                   breakdowns = "age",
                                   sorting = "unique_impressions_descending",
                                   filtering = "[{'field':'age','operator':'IN','value':['18-24','25-34']}]",
                                   date_start = "2016-10-01",
                                   date_stop = "2016-10-10",
                                   access_token = token)
```
                                                       
---

## *Автор пакета: Алексей Селезнёв, Head of Analytics Dept. at Netpeak*
<table>
    <tr>
      <td>
      <img align="right" src="https://lh3.googleusercontent.com/R-0jgJSxIIhpag2L6YCIhJVIcIWx6-Jt5UCTRJjWzJewo47u2QBnik5CRF2dNB79jmsN_BFRjVOAYfvCqFcn3UNS_thGbbxF-99c9lwBWWlFI7JCWE43K5Yk9HnIW8i8YpTDx3l28IuYswaI-qc9QosHT1lPCsVilTfXTyV2empF4S74daOJ6x5QHYRWumT_2MhUS0hPqUsKVtOoveqDnGf3cF_VsN-RfOAwG9uCeGOgNRgv_fhSr41rw4LBND4gf05nO8zMp4TZMrrcUjKvvx6qNgYDor5LFOHiRmfKISYRVkWYe4wLyGO1FgkgTDjg0300lcur2t3txVwZUgROLZdaxOLx4owa8Rc8B8VKwd3vHxjov_aVfNPT4xf9jSFBBEOI-mfYpa55ejKDw-rqTQ6miFRFWpp_hjrk9KbGyB-Z6iZvYL-2dZ6mzgpUfs2I0tEAGsV07yTzboJ0RNCByC2-U-ZVjWdp2_9Au3FFoUcdQUAmPYOVqOv4r3oLbkkJKLj2A5jp7vf4IAoExLIfJuqEf7XN7fFcv4geib029qJjBt28wnqSO6TKEwB2fesR3uPHvGB6_6NHD70UDH-aCRCK4UBeoajtU0Y8Ks8Vwxo0oZBwmoEu8gudTFBF6mDT7GjLoGLDeNxE-TG7OtWUdxsJk7yzXGW3hE-VxsMD9g=s351-no?w=100" height="150">
      </td>
      <td>
        <b>Контакты</b>
        <br>email: selesnow@gmail.com
        <br>skype: selesnow
        <br>telegram: @AlexeySeleznev
      </td>
    </tr>
    <tr>
     <table>
    <tr>
      <td>
        <a href="https://facebook.com/selesnow/">Facebook</a>
      </td>
      <td>
        <a href="https://vk.com/selesnow">Vkontakte</a>
      </td>
      <td>
        <a href="https://linkedin.com/in/selesnow">Linkedin</a>
      </td>
      <td>
        <a href="https://alexeyseleznev.wordpress.com/">Blog</a>
      </td>
      <td>
        <a href="https://github.com/selesnow/">GitHub</a>
      </td>
      <td>
        <a href="https://stepik.org/users/792428">Stepic</a>
      </td>
    </tr>
</table>
    </tr>
</table>
