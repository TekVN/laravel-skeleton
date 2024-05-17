<?php

namespace App\Providers;

use Illuminate\Contracts\Config\Repository;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $configRepository = $this->app->make(Repository::class);
        if ($configRepository->get('app.force_https', false)) {
            URL::forceScheme('https');
        }
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        //
    }
}
