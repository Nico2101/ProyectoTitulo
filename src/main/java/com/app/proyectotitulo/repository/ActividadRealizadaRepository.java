package com.app.proyectotitulo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.app.proyectotitulo.domain.Actividad_Realizada;

@Repository
public interface ActividadRealizadaRepository extends JpaRepository<Actividad_Realizada, Integer> {

	@Query(value = "select * from Actividad_Realizada ar join Temporada t on ar.id_temporada=t.id_temporada where t.estado=1 and t.temporada_eliminada=0 and ar.id_predio=:id_predio", nativeQuery = true)
	List<Actividad_Realizada> listaActividadesAsiganadasAlPredio(@Param("id_predio") int idPredio);

	Actividad_Realizada findByIdActividadRealizada(int idActividadRealizada);

	@Query(value = "select * from Actividad_Realizada ar join Temporada t on ar.id_temporada=t.id_temporada where t.id_temporada=:id_temporada and t.temporada_eliminada=0 and ar.id_predio=:id_predio", nativeQuery = true)
	List<Actividad_Realizada> actividadesAsignadasAPredioEnTemporada(@Param("id_temporada") int idTemporada,
			@Param("id_predio") int idPredio);
	
	
	@Query(value = "SELECT ar.id_actividad_realizada, ar.cantidad_cosechada, ar.fecha_ejecucion_real, ar.id_actividad, ar.id_temporada, ar.id_predio, ar.fecha_estimada  FROM Actividad_Realizada  ar WHERE ar.fecha_estimada BETWEEN NOW( )  AND DATE_ADD( NOW( ) , INTERVAL +5 DAY ) ORDER BY ar.fecha_estimada ASC", nativeQuery = true)
	List<Actividad_Realizada> listaActividadesRealizadas();

}
