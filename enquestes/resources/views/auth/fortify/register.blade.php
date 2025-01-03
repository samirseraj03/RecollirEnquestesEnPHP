@extends('layouts.app')



@section('content')

@if(session('error'))
    <div id="errorAlert" class="alert alert-danger alert-dismissible fade show" role="alert">
        {{ session('error') }}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">X</button>
    </div>
    <script>
        // Cerrar automáticamente el mensaje después de 5 segundos
        setTimeout(function() {
            document.getElementById('errorAlert').style.display = 'none';
        }, 5000);
    </script>
@endif



<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card linear-gradient_css">
                <div class="card-header">{{ __('Register') }}</div>

                @if(session('error'))
                <script>
                    alert("{{ session('error') }}");
                </script>
                @endif

                <div class="card-body">
                    <form method="POST" id="cocacolaEspuma" action="{{ route('register') }}">
                        @csrf

                        <div class="form-group row">
                            <label for="nombre" class="col-md-4  col-form-label text-md-right">{{ __('nombre') }}</label>

                            <div class="col-md-6 mb-2">
                                <input id="name" type="text" class="form-control @error('name') is-invalid @enderror" name="nombre" value="{{ old('name') }}" required autocomplete="name" autofocus>
                                @error('nombre')
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $message }}</strong>
                                </span>
                                @enderror
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="correo" class="col-md-4 col-form-label text-md-right">{{ __('Email Address') }}</label>

                            <div class="col-md-6 mb-2">
                                <input id="correo" id="email" type="email" class="form-control @error('correo') is-invalid @enderror" name="correo" value="{{ old('email') }}" required autocomplete="email">
                                <span class="error" id="emailError"></span>
                                @error('correo')
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $message }}</strong>
                                </span>
                                @enderror
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="contrasenya" class="col-md-4 col-form-label text-md-right">{{ __('Password') }}</label>

                            <div class="col-md-6 mb-2 ">
                                <input id="password" type="password" class="form-control @error('password') is-invalid @enderror" name="contrasenya" required autocomplete="new-password">
                                <span class="error" id="passwordError"></span>

                                @error('contrasenya')
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $message }}</strong>
                                </span>
                                @enderror
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="password-confirm" class="col-md-4 col-form-label text-md-right">{{ __('Confirm Password') }}</label>

                            <div class="col-md-6 mb-2">
                                <input id="password-confirm" type="password" class="form-control" name="contrasenya" required autocomplete="new-password">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="password-confirm" class="col-md-4 col-form-label text-md-right">{{ __('Ets Enquestador ?') }}</label>

                            <div class="col-md-6 mb-2">
                                <select name="enquestador" id="enquestador" class="form-control" id="">
                                    <option default value="no">NO</option>
                                    <option value="si">SI</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row" id="selectEmpresa" style="display: none;">

                            <label for="empresa" class="col-md-4 col-form-label text-md-right">{{ __('De Quina Empresa ets ?') }}</label>

                            <div class="col-md-6">
                                <select name="idEmpresa" class=" form-select form-select-lgs mb-3" aria-label="Large select example">
                                    <option value="" selected></option>
                                    @foreach ($empresas as $empresa)
                                    <option value="{{ $empresa->id_empresa }}">{{ $empresa->nombre }}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                        <div class="form-group row mb-0">
                            <div class="col-md-6 offset-md-4">
                                <button type="submit" class="btn btn-primary">
                                    {{ __('Register') }}
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    var token = $('meta[name="csrf-token"]').attr('content');
    $(document).ready(function() {

        // Agrega un evento change al select de empresas
        $('#enquestador').change(function() {
            // Obtén el valor seleccionado
            let opcionSeleccionada = $(this).find('option:selected').text();

            if (opcionSeleccionada === 'SI') {
                // Mostrar el select
                $('#selectEmpresa').css('display', 'flex');
            } else {
                // Ocultar el select
                $('#selectEmpresa').css('display', 'none');
            }

        });
    });
</script>




@endsection