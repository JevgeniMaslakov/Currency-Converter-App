Currency Converter App
Описание
Currency Converter App — это мобильное приложение на Flutter с поддержкой Material Design, авторизацией через Google и хранением истории конверсий в Firebase. Приложение разработано для курса [название курса] как учебный проект.

Переводит валюты (USD, EUR, GBP, JPY, RUB)

Сохраняет историю конверсий в облаке (Firebase)

Авторизация через Google

Современный дизайн, простая и понятная навигация


Функционал
3+ экрана: Главная (конвертер), История, Профиль

Навигация: BottomNavigationBar

Авторизация: Google Sign-In (Firebase Auth)

Синхронизация данных: Cloud Firestore (каждый пользователь видит только свою историю)

Асинхронная работа: Все операции с БД и сетью — через Future/Stream

Обработка ошибок: Сообщения пользователю при ошибках/нет соединения

Приятный внешний вид: Material Design

Структура проекта
bash
Копировать
Редактировать
lib/
main.dart                # Главная точка входа, инициализация Firebase
screens/
main_screen.dart       # Экран конвертера
history_screen.dart    # Экран истории операций
profile_screen.dart    # Профиль пользователя
services/
history_service.dart   # Работа с Firestore
auth_service.dart        # Работа с Google Sign-In
Как запустить
Клонируйте репозиторий

bash
Копировать
Редактировать
git clone <ваша_ссылка>
cd <папка_проекта>
Установите зависимости

arduino
Копировать
Редактировать
flutter pub get
Настройте Firebase

Зарегистрируйте приложение в Firebase Console

Укажите тот же applicationId, что и в android/app/build.gradle.kts

Скачайте и положите файл google-services.json в папку android/app/

Включите Google Sign-In в Firebase Authentication

Добавьте SHA-1 отпечаток вашего debug-ключа

Запустите приложение

arduino
Копировать
Редактировать
flutter run
Возможные проблемы
Если видите ошибку [core/duplicate-app], полностью удалите приложение с эмулятора/устройства, очистите проект flutter clean и запустите снова.

Иногда старый эмулятор Android может кэшировать старую сборку, в этом случае помогает создание нового эмулятора.

Если нужна помощь — пишите в issues.

Евгений Маслаков
