<?php

// autoload_classmap.php @generated by Composer

$vendorDir = dirname(dirname(__FILE__));
$baseDir = dirname($vendorDir);

return array(
    'BaseController' => $baseDir . '/app/controllers/BaseController.php',
    'Cartalyst\\Sentry\\Groups\\GroupExistsException' => $vendorDir . '/cartalyst/sentry/src/Cartalyst/Sentry/Groups/Exceptions.php',
    'Cartalyst\\Sentry\\Groups\\GroupNotFoundException' => $vendorDir . '/cartalyst/sentry/src/Cartalyst/Sentry/Groups/Exceptions.php',
    'Cartalyst\\Sentry\\Groups\\NameRequiredException' => $vendorDir . '/cartalyst/sentry/src/Cartalyst/Sentry/Groups/Exceptions.php',
    'Cartalyst\\Sentry\\Throttling\\UserBannedException' => $vendorDir . '/cartalyst/sentry/src/Cartalyst/Sentry/Throttling/Exceptions.php',
    'Cartalyst\\Sentry\\Throttling\\UserSuspendedException' => $vendorDir . '/cartalyst/sentry/src/Cartalyst/Sentry/Throttling/Exceptions.php',
    'Cartalyst\\Sentry\\Users\\LoginRequiredException' => $vendorDir . '/cartalyst/sentry/src/Cartalyst/Sentry/Users/Exceptions.php',
    'Cartalyst\\Sentry\\Users\\PasswordRequiredException' => $vendorDir . '/cartalyst/sentry/src/Cartalyst/Sentry/Users/Exceptions.php',
    'Cartalyst\\Sentry\\Users\\UserAlreadyActivatedException' => $vendorDir . '/cartalyst/sentry/src/Cartalyst/Sentry/Users/Exceptions.php',
    'Cartalyst\\Sentry\\Users\\UserExistsException' => $vendorDir . '/cartalyst/sentry/src/Cartalyst/Sentry/Users/Exceptions.php',
    'Cartalyst\\Sentry\\Users\\UserNotActivatedException' => $vendorDir . '/cartalyst/sentry/src/Cartalyst/Sentry/Users/Exceptions.php',
    'Cartalyst\\Sentry\\Users\\UserNotFoundException' => $vendorDir . '/cartalyst/sentry/src/Cartalyst/Sentry/Users/Exceptions.php',
    'Cartalyst\\Sentry\\Users\\WrongPasswordException' => $vendorDir . '/cartalyst/sentry/src/Cartalyst/Sentry/Users/Exceptions.php',
    'CronratController' => $baseDir . '/app/controllers/CronratController.php',
    'CronratUrl' => $baseDir . '/app/controllers/CronratUrl.php',
    'DatabaseSeeder' => $baseDir . '/app/database/seeds/DatabaseSeeder.php',
    'FbgBackup' => $baseDir . '/app/commands/FbgBackup.php',
    'FbgRestore' => $baseDir . '/app/commands/FbgRestore.php',
    'GroupController' => $baseDir . '/app/controllers/GroupController.php',
    'HomeController' => $baseDir . '/app/controllers/HomeController.php',
    'IlluminateQueueClosure' => $vendorDir . '/laravel/framework/src/Illuminate/Queue/IlluminateQueueClosure.php',
    'Lasdorf\\CronratApi\\CronratApi' => $baseDir . '/app/libraries/Lasdorf/Cronrat/CronratApi.php',
    'Lasdorf\\CronratApi\\CronratBase' => $baseDir . '/app/libraries/Lasdorf/Cronrat/CronratBase.php',
    'Lasdorf\\CronratApi\\Crontab' => $baseDir . '/app/libraries/Lasdorf/Cronrat/Crontab.php',
    'Lasdorf\\Fbg\\FbgApi' => $baseDir . '/app/libraries/Lasdorf/Fbg/FbgApi.php',
    'Lasdorf\\Fbg\\FbgBase' => $baseDir . '/app/libraries/Lasdorf/Fbg/FbgBase.php',
    'Lasdorf\\Fbg\\FbgUtils' => $baseDir . '/app/libraries/Lasdorf/Fbg/FbgUtils.php',
    'Lasdorf\\FormattedJsonResponse\\FormattedJsonResponse' => $baseDir . '/app/libraries/Lasdorf/FormattedJsonResponse/FormattedJsonResponse.php',
    'Lasdorf\\Utils' => $baseDir . '/app/libraries/Lasdorf/Utils.php',
    'MigrationCartalystSentryInstallGroups' => $vendorDir . '/cartalyst/sentry/src/migrations/2012_12_06_225929_migration_cartalyst_sentry_install_groups.php',
    'MigrationCartalystSentryInstallThrottle' => $vendorDir . '/cartalyst/sentry/src/migrations/2012_12_06_225988_migration_cartalyst_sentry_install_throttle.php',
    'MigrationCartalystSentryInstallUsers' => $vendorDir . '/cartalyst/sentry/src/migrations/2012_12_06_225921_migration_cartalyst_sentry_install_users.php',
    'MigrationCartalystSentryInstallUsersGroupsPivot' => $vendorDir . '/cartalyst/sentry/src/migrations/2012_12_06_225945_migration_cartalyst_sentry_install_users_groups_pivot.php',
    'Omnipay\\Omnipay' => $vendorDir . '/omnipay/common/src/Omnipay/Omnipay.php',
    'Redbean\\R' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_Adapter' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_Adapter_DBAdapter' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_AssociationManager' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_AssociationManager_ExtAssociationManager' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_BeanHelper' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_BeanHelper_Facade' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_DependencyInjector' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_Driver' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_Driver_PDO' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_DuplicationManager' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_Exception' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_Exception_SQL' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_Exception_Security' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_Facade' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_Finder' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_IModelFormatter' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_LabelMaker' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_Logger' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_Logger_Default' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_ModelHelper' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_OODB' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_OODBBean' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_Observable' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_Observer' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_Plugin' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_Plugin_BeanCan' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_Plugin_Cache' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_Plugin_Cooker' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_Plugin_QueryLogger' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_QueryWriter' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_QueryWriter_AQueryWriter' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_QueryWriter_CUBRID' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_QueryWriter_MySQL' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_QueryWriter_PostgreSQL' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_QueryWriter_SQLiteT' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_SQLHelper' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_Setup' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_SimpleModel' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_TagManager' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'Redbean\\RedBean_ToolBox' => $vendorDir . '/lj4/redbean-laravel4/src/include/rbn.php',
    'SentryGroupSeeder' => $baseDir . '/app/database/seeds/SentryGroupSeeder.php',
    'SentryUserGroupSeeder' => $baseDir . '/app/database/seeds/SentryUserGroupSeeder.php',
    'SentryUserSeeder' => $baseDir . '/app/database/seeds/SentryUserSeeder.php',
    'SessionHandlerInterface' => $vendorDir . '/symfony/http-foundation/Symfony/Component/HttpFoundation/Resources/stubs/SessionHandlerInterface.php',
    'Symfony\\Component\\HttpFoundation\\Resources\\stubs\\FakeFile' => $vendorDir . '/symfony/http-foundation/Symfony/Component/HttpFoundation/Resources/stubs/FakeFile.php',
    'TestCase' => $baseDir . '/app/tests/TestCase.php',
    'User' => $baseDir . '/app/models/User.php',
    'UserController' => $baseDir . '/app/controllers/UserController.php',
    'VerifyController' => $baseDir . '/app/controllers/VerifyController.php',
);
