package com.app.proyectotitulo.service;


import java.util.List;


import com.app.proyectotitulo.domain.Actividad_Realizada;

public interface ActividadRealizadaService {
	
	
	
	Actividad_Realizada saveAndFlush(Actividad_Realizada ar);

	List<Actividad_Realizada> listaActividadesAsignadasAPredio(int idPredio);

	Actividad_Realizada buscarActividad(int idActividadRealizada);

	public void save(Actividad_Realizada ar);

}
