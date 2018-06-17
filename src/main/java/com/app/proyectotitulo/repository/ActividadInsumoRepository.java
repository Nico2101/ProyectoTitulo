package com.app.proyectotitulo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Actividad_Insumo;

@Repository
public interface ActividadInsumoRepository extends JpaRepository<Actividad_Insumo, Integer> {

	List<Actividad_Insumo> findByActividadRealizadaIdActividadRealizada(int idActividadRealizada);

	Actividad_Insumo findByIdActividadInsumo(int idActividadInsumo);
	
	@Query(value = "select sum(ai.costo) as costos from Actividad_Insumo ai join Actividad_Realizada ar on ai.id_actividad_realizada=ar.id_actividad_realizada where ar.id_predio=? and ar.id_temporada=?", nativeQuery = true)
	Integer obtenerCostos(int idPredio, int idTemporada);

	

}
