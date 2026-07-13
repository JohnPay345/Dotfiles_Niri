// Конфиг для производительности

// 1. Включение агрессивной выгрузки (усыпления) вкладок при нехватке памяти
user_pref("browser.tabs.unloadOnLowMemory", true);

// 2. Время в секундах (300 сек = 5 мин), после которого фоновая вкладка готова к выгрузке
user_pref("browser.tabs.min_inactive_duration_before_unload", 300);

// 3. Ограничение количества процессов до 2
user_pref("dom.ipc.processCount", 2);

// 4. Отключение встроенных рекомендаций Pocket
user_pref("extensions.pocket.enabled", false);
