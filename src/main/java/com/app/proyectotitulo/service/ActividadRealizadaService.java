package com.app.proyectotitulo.service;

import java.util.List;

import com.app.proyectotitulo.domain.Actividad_Realizada;

public interface ActividadRealizadaService {

	List<Actividad_Realizada> listaActividadesAsignadasAPredio(int idPredio);

	Actividad_Realizada buscarActividad(int idActividadRealizada);

}
