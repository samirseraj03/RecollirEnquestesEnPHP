<?php


use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HelloController;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\EnquestaController;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/


Route::get('/hello', [HelloController::class, 'index']);
Route::get('/home', [HomeController::class, 'mostrarEmpresa']);
Route::get('/enquesta', [EnquestaController::class,'mostrarEnquesta'])->name('enquesta');


// apis 
Route::get('/enquestas', [EnquestaController::class,'GetALLEnquestas'])->name('enquesta');

Route::get('/enquestas/{id}', [HomeController::class,'getEncuestasPorEmpresaWithid']);

Route::get('/enquestas/{id}/{preguntas}', [HomeController::class,'getEncuestasPorEmpresaWithid']);



