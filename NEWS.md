## rfacebookstat 1.9.0
Дата релиза: 2019-05-21
CСсылка на подробное описание релиза: [Link](https://github.com/selesnow/rfacebookstat/releases/tag/1.9.0)
#### Что нового
* Новая функция `fbGetCatalogs` предназначенная для загрузки каталогов;
* Опции, для упрощения и компактности синтаксиса в пакет добавлены 4 опции
    * rfacebookstat.api_version - Версия API, по умолчанию v3.3
	* rfacebookstat.access_token - Токен доступа к API
	* rfacebookstat.accounts_id - ID рекламного аккаунта
	* rfacebookstat.business_id - ID бизнес менеджера
* Упрощённый формат фильтрации данных, пример `"impressions LESS_THAN 5000"`;
* Исправлена ошибка возникающая при загрузке action и применения action_breakdowns;
* В пакет добавлена виньетка посвящённая загрузки статистики из рекламных аккаунтов Facebook: `vignette('rfacebookstat-get-statistics', package = 'rfacebookstat')`;
* Добавлен обработчик лимитов API;
* В результат возвращаемый функцией `fbGetAdCreative` добавлено поле *link_nested* с данными по дочерним ссылкам из кольцевой галереи.
