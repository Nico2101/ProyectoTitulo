package com.app.proyectotitulo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Actividad_Insumo;
import com.app.proyectotitulo.domain.Predio;

@Repository
public interface ActividadInsumoRepository extends JpaRepository<Actividad_Insumo, Integer> {

	List<Actividad_Insumo> findByActividadRealizadaIdActividadRealizada(int idActividadRealizada);

	Actividad_Insumo findByIdActividadInsumo(int idActividadInsumo);
	
	@Query(value = "select ai.costo, ai.id_insumo from Actividad_Insumo ai  join Actividad_Realizada ar on ai.id_actividad_realizada=ar.id_actividad_realizada where ar.id_predio=?", nativeQuery = true)
	List<Actividad_Insumo> obtenerCostos(int idPredio);

}
