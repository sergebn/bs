;; Создать проект компонента joomla

(defun newtex()
  "Get data from the file com_templ.xml"
  (interactive)
    ; вставить данные из файла com_templ.xml
    (insert-file-contents "com_templ.xml")
    ; разделить строки
    (split-string (buffer-string) "\n" t)
    ; найти и заменить. Получить имя компонента и заменить все вхождения
    ; COMPONENT_NAME на имя компонента
    (let ((case-fold-search t)) ; or nil
      (goto-char (point-min))
      (while (search-forward "COMPONENT_NAME" nil t) (replace-match "COMPONENT_NAME_NAME"))
      (goto-char (point-min))
      (while (search-forward "myReplaceStr2" nil t) (replace-match "myReplaceStr2"))
      ;; repeat for other string pairs
      )
)
;; idiom for string replacement in current buffer;


Для нашего простейшего компонента потребуется создать всего пять файлов:

    com_hello/hello.php - точка входа в компонент
    com_hello/controller.php - содержит основное управление компонентом
    com_hello/views/hello/view.html.php - обрабатывает данные и передает их в шаблон для вывода
    com_hello/views/hello/tmpl/default.php - шаблон для вывода данных
    com_hello/hello.xml- XML служит для передачи инструкций для Joomla по установке компонента

Joomla всегда обрабатывает ссылку в корневом файле index.php для страниц Front End (сайт) или administrator/index.php для страниц Back End (панель администратора). Функция обработки URL загрузит требуемый компонент, основанный на значении "option" в URL (метод GET) или переданных данных методом POST.

Для нашего компонента, URL выглядит так:
index.php?option=com_hello&view=hello

Эта ссылка запустит выполнение файла, являющего точкой входа в наш компонент: COMPONENT_NAMEs/com_hello/hello.php.

Код для этого файла довольно типичен для всех компонентов.
<?php
/**
 * @package    Autor
 * @subpackage COMPONENT_NAMEs
 * COMPONENT_NAMEs/com_hello/hello.php
 * @link http://autor.net/
 * @license    GNU/GPL
*/
 
// Защита от прямого обращения к скрипту
defined( '_JEXEC' ) or die( 'Restricted access' );

//Проверка определения DS
if(!defined('DS')){
	define('DS', DIRECTORY_SEPARATOR);
}
 
// Подключение файла контроллера.
require_once( JPATH_COMPONENT_NAME.DS.'controller.php' );
 
// Проверка или требуется определенный контроллер
if($controller = JRequest::getVar( 'controller' )) {
    require_once( JPATH_COMPONENT_NAME.DS.'controllers'.DS.$controller.'.php' );
}
 
// Создание класса нашего компонента
$classname    = 'HelloController'.$controller;
$controller   = new $classname( );
 
// Выполнить задачу запроса
$controller->execute( JRequest::getVar( 'task' ) );
 
// Переадресация
$controller->redirect();
?>

Стоит заметить, что

JPATH_COMPONENT_NAME - это абсолютный путь к текущему компоненту, в нашем случае COMPONENT_NAMEs/com_hello.

JPATH_COMPONENT_NAME_SITE - Для Front End

JPATH_COMPONENT_NAME_ADMINISTRATOR - Для Back End

DS - является автоматическим выбором слеша ( разделителя директорий ) '\' или '/'.

После загрузки основного контроллера проверяется наличие определенного контроллера с последующей загрузкой. В данном случае у нас только основной контроллер. JRequest::getVar() загружает значение переменной из URL или переданной методом POST. Допустим мы имеем адрес следующего вида:
index.php?option=com_hello&controller=controller_name

Тогда можно определить название нашего контроллера следующим образом:
echo JRequest::getVar('controller', 'default');

Мы имеем основной контроллер НelloController в com_hello/controller.php, так же загружаются дополнительные названия контроллера, к примеру: для HelloControllerController1 класс будет объявлен в файле com_hello/controllers/controller1.php 

{COMPONENT_NAMEname}{Controller}{Controllername} - Такой стандарт упрощает схему многозадачного компонента.

После того, как контроллер создан, мы инструктируем его выполнить задачу, которая определяется переданными параметрами в URL (либо через POST):

index.php?option=com_hello&task=sometask.

Если переменная "task" явно не задана, то по умолчанию выполниться display(), задача которого просто вывести шаблон по умолчанию. Пример стандартных задач - save, edit, new и т. д.

На этом шаге контроллер переадресовывает страницу. Обычно используется для таких задач как save.

Главная точка входа (hello.php) по существу пропускает управление на контроллер, который обрабатывает выполнение задачи, которая была определена в запросе.
создание контроллера

Наш компонент имеет только одну задачу - Hello. Поэтому, контроллер будет очень простой. Никакая манипуляция данных не требуется. Все что необходимо - это загрузить соответствующий вид(view). Остальные возможности контроллера пока пропустим

Код основного контроллера:
<?php
/**
 * @package    Autor
 * @subpackage COMPONENT_NAMEs
 * @link http://autor.net/
 * @license    GNU/GPL
 */
 
// no direct access
defined( '_JEXEC' ) or die( 'Restricted access' );
 
jimport('joomla.application.COMPONENT_NAME.controller');
 
/**
 * Hello World COMPONENT_NAME Controller
 * @package    Joomla.Tutorials
 * @subpackage COMPONENT_NAMEs
 */
class HelloController extends JController
{
    /**
     * Method to display the view
     * @access    public
     */
    function display()
    {
        parent::display();
    }
 
}
?>

Конструктор класса JController всегда будет регистрировать задачу display(). Этот метод сам определит необходимый шаблон и данные которые необходимо загрузить в него. Более того один шаблон может разделяться на уровни(layout), каждый из которых отобразиться при запуске определенной задачи. В нашем случае мы явно не прописываем имя задачи, поэтому (как уже указывалось выше) используется default.

Когда вы создаете пункт меню для вашего компонента, менеджер меню позволит администратору выбирать задачу с которой начинать выполнение компонента. К примеру, для стандартного компонента "Пользователь" (com_user), выбор задач при создании пункта меню будет следующим:

    Разметка входа по умолчанию
    Разметка по умолчанию для регистрации
    Напоминание по умолчанию
    Разметка по умолчанию для сброса
    Разметка по умолчанию для пользователя
    Разметка пользовательской формы

создание вида

Извлекаем необходимые данные и передаем их в шаблон. В этом нам поможет расширенный класс JView и его метод assignRef, с помощью которого мы передаем переменные в шаблон.

<>Пример кода вида:
<?php
/**
 * @package    Autor
 * @subpackage COMPONENT_NAMEs
 * @link http://autor.net/
 * @license    GNU/GPL
*/
 
// no direct access
defined( '_JEXEC' ) or die( 'Restricted access' );
 
jimport( 'joomla.application.COMPONENT_NAME.view');
 
/**
 * HTML View class for the HelloWorld COMPONENT_NAME
 *
 * @package    HelloWorld
 */
 
class HelloViewHello extends JView
{
    function display($tpl = null)
    {
        $greeting = "Hello World!";
        $this->assignRef('greeting', $greeting );
        parent::display($tpl);
    }
}
?>

создание шаблона

Наш шаблон очень прост, мы только отображаем приветствие, которое передавали в view:
<?php // no direct access
defined('_JEXEC') or die('Restricted access'); ?>
<h1><?php echo $this->greeting; ?></h1>

создание файла hello.xml

Можно установить компонент вручную, копирую файлы по FTP протоколу создавая необходимые папки и таблицы в базе данных, но лучшим вариантом является использования установочного файла для пакетной загрузки файлов и установки компонента

    детали о компоненте и о авторе компонента.
    список файлов, которые должны быть скопированы.
    внешний PHP файл, который исполняет дополнительную установку и деинсталлирует операции.
    внешние SQL файлы, которые содержит запросы к базе данных, отдельно для установки и удаления

Формат XML файла следующий:
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE install SYSTEM "http://dev.joomla.org/xml/1.5/COMPONENT_NAME-install.dtd">
<install type="COMPONENT_NAME" version="1.5.0">
    <name>Hello</name>
    <!-- Далее идут элементы, которые содержат не обязательные данные,
         но тем не менее их желательно заполнить -->
    <creationDate>2007 02 22</creationDate>
    <author>John Doe</author>
    <authorEmail>john.doe@example.org</authorEmail>
    <authorUrl>http://www.example.org</authorUrl>
    <copyright>Copyright Info</copyright>
    <license>License Info</license>
    <!--  Версия компонента, может использоваться для обновлений -->
    <version>COMPONENT_NAME Version String</version>
    <!-- Краткое описание возможностей компонента -->
    <description>Description of the COMPONENT_NAME ...</description>
 
    <!-- Опции копирования файлов при установке -->
    <files folder="cite">
        <filename>index.html</filename>
        <filename>hello.php</filename>
        <filename>controller.php</filename>
        <filename>views/index.html</filename>
        <filename>views/hello/index.html</filename>
        <filename>views/hello/view.html.php</filename>
        <filename>views/hello/tmpl/index.html</filename>
        <filename>views/hello/tmpl/default.php</filename>
    </files>
 
    <administration>
        <!-- Имя пункта меню в панели управления -->
        <menu>Hello World!</menu>
 
        <!-- Файлы для копирования в панель администратора -->
        <files folder="administrator">
            <filename>index.html</filename>
            <filename>admin.hello.php</filename>
        </files> 
    </administration>
</install>

Также есть файл, который будет скопирован, это - index.html.

index.html помещен в каждый каталог, чтобы препятствовать пользователям получать список файлов каталога. Эти файлы содержат одну единственную строку:
<html><body bgcolor="#FFFFFF"></body></html>
