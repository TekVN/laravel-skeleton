<?php

use Illuminate\Support\Arr;

return [
    'proxies' => Arr::wrap(env('TRUSTED_PROXIES', [
        '127.0.0.1',
        '::1',
    ])),
];
